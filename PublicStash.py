"""
Provides a class for Path of Exile public stashes.
Call directly to monitor stashes.
"""
from time import sleep

import requests
from MySQLDatabase import MySQLDatabase as Database

from StashItem import StashItem


class PublicStash:
    """
    A class representing a public stash tab.
    """
    def __init__(self, stash, database):
        self.table_name = "publicStashTabs"

        self.stash_id = stash['id']

        self.database = database
        self.database.connect()
        self._database_worker(stash)
        self.database.commit()

    def _database_worker(self, stash_data):
        stash_properties = {key:value for key, value \
                            in stash_data.items() \
                            if not isinstance(value, list)}

        query_fields = "(`{0}`)".format("`, `".join(
            [key for key in stash_properties.keys()]))
        query_values = tuple(stash_properties.values())
        query_items = ", ".join(
            ["`"+key+"`=%s" for key in stash_properties.keys()])

        query_string = "INSERT INTO `"+self.table_name+"` " + \
            query_fields + \
            "VALUES ("+",".join(
                ["%s" for _ in range(len(stash_properties))])+") " \
            "ON DUPLICATE KEY UPDATE "+query_items

        self.database.query(query_string, query_values+query_values)

        _ = [self._dispatcher(key, value) for key, value \
            in stash_data.items() if isinstance(value, list)]

    def _dispatcher(self, key, value):
        if key == "items":
            _ = [StashItem(
                self.stash_id,
                item_data,
                self.database) \
                     for item_data in value]

if __name__ == "__main__":
    NEXT_CHANGE_ID = None
    DATABASE = Database(
        'localhost',
        'poe_public_stash',
        'WYPuw4LWPKjMy8jZ',
        'pathofexile')
    try:
        while True:
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

            print("Processing {} public stashes.Next change ID: {}".\
                format(
                    len(PUBLIC_STASH_DATA['stashes']), NEXT_CHANGE_ID))
            _ = [PublicStash(stash, DATABASE) \
                for stash in PUBLIC_STASH_DATA['stashes']]
            sleep(1)

    except KeyboardInterrupt:
        print("Shutting down...")
