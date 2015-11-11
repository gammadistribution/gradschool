import datetime
import json
import logging
import logging.config
import os
import re
from settings import twitter_stream_settings as tss
import sqlite3
import sys
import tweepy


logging.config.fileConfig(tss.logger_config)
logger = logging.getLogger('twitter_stream')


class EndStreamException(Exception):
    """Raise this exception if the stream needs to end.
    """
    def __init__(self, message):
        self.message = message


class DBStreamListener(tweepy.StreamListener):
    """Class that inherits from tweepy.StreamListener. Saves tweets that are
    streamed through this listener to the specified sqlite3 database.
    """
    def __init__(self, logger, database, hashtag, queries_path):
        super().__init__()
        self.database = database
        self.hashtag = hashtag
        self.logger = logger
        self.queries = self.retrieve_queries(queries_path)
        self.start_time = datetime.datetime.now()
        self.interval_start_time = self.start_time

    def retrieve_queries(self, queries_path):
        """Create dictionary of queries found in the queries_path. For all
        files ending in .sql, add filename as key and file contents as value.

        Returns resulting dictionary.
        """
        queries = {}
        regex = '(?P<query>.*).sql'

        for root, dirs, files in os.walk(queries_path):
            for filename in files:
                if re.search(regex, filename):
                    with open(os.path.join(root, filename)) as query:
                        key = re.search(regex, filename).group('query')
                        queries.update({key: query.read()})

        return queries

    def on_connect(self):
        """Execute the following when the stream first connects to the twitter
        stream.
        """
        self.connection = sqlite3.connect(self.database)
        self.cursor = self.connection.cursor()

        try:
            self.cursor.execute(self.queries['create_tweets_table'])
        except sqlite3.OperationalError:
            message = 'The table tweets already exists in db. '
            message += 'Skipping creation.'
            self.logger.info(message)

        return

    def on_status(self, status):
        """Execute the following when a new tweet is streamed to the listener
        instance. Parse the status object for the created_at, text,
        and user.screen_name properties, then insert into the database cursor.
        Commit database connection every preset interval as defined in
        settings.
        """
        # Gather the values to insert into database in the following order:
        # hashtag, screen_name, created_at, text.
        values = (
            self.hashtag,
            status.user.screen_name,
            datetime.datetime.strftime(status.created_at,
                                       '%Y-%m-%d %H:%M:%S'),
            status.text
        )

        self.cursor.execute(self.queries['insert_tweet'], values)

        # If the elapsed time is greater than the predefined interval,
        # save cursor data to connection.
        current_time = datetime.datetime.now()
        if current_time - self.interval_start_time > tss.interval:
            self.logger.info('Commiting to database.')
            self.connection.commit()
            self.interval_start_time = datetime.datetime.now()

        # End stream if past duration setting
        if current_time - self.start_time > tss.stream_duration:
            self.logger.info('Ending stream.')
            self.connection.commit()
            self.connection.close()

            raise EndStreamException('Stream ended at {}'.format(current_time))

        return

    def on_exception(self, exception):
        """If an exception occurs during the twitter stream process, log the
        exception. Then commit the database connection.
        """
        self.logger.error('The following exception occured: {}'.format(exception))

        self.connection.commit()

        raise exception

    def on_limit(self, track):
        """If rate limit warning is parsed by the twitter stream process, log
        the event. Then commit the database connection.
        """
        self.logger.warn('Limit warning detected: {}'.format(track))

        self.connection.commit()

        return

    def on_error(self, status_code):
        """If http status code is an error code, log the status_code and defer
        to tweepy. Then commit the database connection.
        """
        message = 'The following HTTP error code occured: {}'
        self.logger.error(message.format(status_code))

        self.connection.commit()

        return

    def on_timeout(self):
        """If connection times out, log the event. Then commit the
        database connection.
        """
        self.logger.warn('The connection has timed out')

        self.connection.commit()

        return

    def on_disconnect(self, notice):
        """If twitter sends a disconnect notice, log the event. Then commit
        the database connection.
        """
        self.logger.critical('The connection has ended: {}'.format(notice))

        self.connection.commit()
        self.connection.close()

        return False

    def commit(self):
        """Commit data and close connection
        """
        self.connection.commit()
        self.connecion.close()


def create_api_handle(credentials):
    """Using the passed credentials json object, create tweepy.API handle
    to access TwitterAPI.
    """
    auth = tweepy.OAuthHandler(credentials['consumer']['token'],
                               credentials['consumer']['secret'])

    auth.set_access_token(credentials['access']['token'],
                          credentials['access']['secret'])

    api = tweepy.API(auth)

    return api


def get_credentials(credentials_path, required_keys=tss.required_keys):
    """Retrieve credentials necessary to authenticate connection to Twitter
    through its API. If credentials_path file is not found, log error and exit
    application. Validate that json object from credentials_path contains
    correct objects within credentials as required.
    """
    try:
        with open(credentials_path) as path:
            credentials = json.load(path)
    except FileNotFoundError as exc:
        logger.critical(exc)
        sys.exit()

    logger_message = 'Key {key} not found in credentials.'
    for key in required_keys:
        if key not in credentials.keys():
            logger.critical(logger_message.format(**{'key': key}))
            sys.exit()
        for sub_key in required_keys[key]:
            if sub_key not in credentials[key].keys():
                logger.critical(logger_message.format(**{'key': sub_key}))
                sys.exit()

    return credentials


def main():
    logger.info('Retrieving credentials.')
    credentials = get_credentials(tss.credentials_path)

    logger.info('Creating Twitter API handle.')
    api = create_api_handle(credentials)

    logger.info('Creating DBStreamListener instance')
    stream_listener = DBStreamListener(logger, tss.database_path, tss.hashtag,
                                       tss.queries_path)

    logger.info('Attempting to connect stream.')
    stream = tweepy.Stream(auth=api.auth, listener=stream_listener)

    logger.info('Streaming tweets.')

    streaming = True
    while streaming:
        try:
            stream.filter(track=[stream_listener.hashtag])
        except Exception as e:
            if type(e).__name__ == 'EndStreamException':
                streaming = False
                stream_listener.commit()


if __name__ == '__main__':
    main()
