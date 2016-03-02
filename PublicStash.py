"""
Provides a class for Path of Exile public stashes.
Call directly to monitor stashes.
"""
import requests
from MySQLDatabase import MySQLDatabase as Database


class PublicStash:
    """
    A class representing a public stash tab.
    """
    def __init__(self, stash, database):
        self.table_name = "publicStashTabs"

        stash_data = {key:value for key, value in stash.items()
                      if not isinstance(value, list)}

        self.database = database
        self.database.connect()
        self._database_worker(stash_data)
        self.database.commit()

    def _database_worker(self, stash_data):
        query_fields = "(`{0}`)".format("`, `".join(
            [key for key in stash_data.keys()]))
        query_values = tuple(stash_data.values())
        query_items = ", ".join(
            ["`"+key+"`=%s" for key in stash_data.keys()])

        query_string = "INSERT INTO `"+self.table_name+"` " + \
            query_fields + \
            "VALUES ("+",".join(
                ["%s" for _ in range(len(stash_data))])+") " \
            "ON DUPLICATE KEY UPDATE "+query_items

        self.database.query(query_string, query_values+query_values)

if __name__ == "__main__":
    NEXT_CHANGE_ID = None
    DATABASE = Database(
        'localhost',
        'poe_public_stash',
        'WYPuw4LWPKjMy8jZ',
        'pathofexile')
    try:
        if NEXT_CHANGE_ID is not None:
            PARAMETERS = {'id': NEXT_CHANGE_ID}
            REQUEST = requests.get(
                "http://www.pathofexile.com/api/public-stash-tabs",
                params=PARAMETERS)
        else:
            REQUEST = requests.get(
                "http://www.pathofexile.com/api/public-stash-tabs")

        PUBLIC_STASH_DATA = REQUEST.json()

        NEXT_CHANGE_ID = PUBLIC_STASH_DATA['next_change_id']

        for stash in PUBLIC_STASH_DATA['stashes']:
            PublicStash(stash, DATABASE)

    except KeyboardInterrupt:
        raise
