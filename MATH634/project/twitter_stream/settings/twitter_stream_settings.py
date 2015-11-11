import os
import datetime


# The parent_dir of the project is one directories above this current
# directory.
parent_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


# The path leading to the credentials required to authenticate to Twitter.
credentials_path = os.path.join(parent_dir, 'credentials', 'credentials.json')


# The path leading to the database that stores all of the tweets.
database_path = os.path.join(parent_dir, 'database', 'twitter_stream.db')


# The path leading to the queries to use within the database
queries_path = os.path.join(os.path.dirname(database_path), 'queries')


# The path leading to the logging config file
logger_config = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                             'logging', 'logging.ini')


# This is the layout required of the credentials.json object. The keys are the
# top level keys and the values in the list are the sub keys of the keys
required_keys = {
    'consumer': ['token', 'secret'],
    'access': ['token', 'secret']
}


# This is the criteria used to filter incoming streamed tweets.
hashtag = 'thewalkingdead'


# This is how long the process waits before commiting connection
interval = datetime.timedelta(seconds=900)


# This is how long we should stream the tweets.
stream_duration = datetime.timedelta(days=14)
