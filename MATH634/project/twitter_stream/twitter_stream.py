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
        Commit database connection every fifteen minutes.
        """
        return

    def on_exception(self, exception):
        """If an exception occurs during the twitter stream process, log the
        exception. Then commit the database connection.
        """
        return

    def on_limit(self, track):
        """If rate limit warning is parsed by the twitter stream process, log
        the event. Then commit the database connection.
        """
        return

    def on_error(self, status_code):
        """If http status code is an error code, log the status_code and defer
        to tweepy. Then commit the database connection.
        """
        return

    def on_timeout(self):
        """If connection times out, log the event. Then commit the
        database connection.
        """
        return

    def on_disconnect(self, notice):
        """If twitter sends a disconnect notice, log the event. Then commit
        the database connection.
        """
        return False


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


if __name__ == '__main__':
    main()
