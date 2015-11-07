import json
import logging
import logging.config
from settings import twitter_stream_settings as tss
import sys
import tweepy


logging.config.fileConfig(tss.logger_config)
logger = logging.getLogger('twitter_stream')


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


if __name__ == '__main__':
    main()
