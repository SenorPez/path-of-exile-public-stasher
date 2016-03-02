"""
Provides a class for Path of Exile items in a stash.
"""

import hashlib
import json

class StashItem:
    """
    A class representing an item in a stash.
    """
    def __init__(self, stash_id, item_data, database):
        self.table_name = "items"

        self.stash_id = stash_id

        self.database = database
        self._database_worker(item_data)

    def _database_worker(self, item_data):
        #Calculate hash. Do not include notes.
        item_hash = hashlib.md5(bytes(json.dumps(
            {key:value for key, value in item_data.items() \
             if key != "note"},
            sort_keys=True), encoding='utf-8')).hexdigest()

        item_properties = {key:value for key, value \
                           in item_data.items() \
                           if not isinstance(value, list) and \
                                key != "note"}
        item_properties['hash'] = item_hash
        item_properties['publicStashTabID'] = self.stash_id

        query_fields = "(`{0}`)".format("`, `".join(
            [key for key in item_properties.keys()]))
        query_values = tuple(item_properties.values())

        query_string = "INSERT INTO `"+self.table_name+"` " + \
            query_fields + \
            "VALUES ("+",".join(
                ["%s" for _ in range(len(item_properties))])+") " + \
            "ON DUPLICATE KEY UPDATE `hash`=`hash`"

        self.database.query(query_string, query_values)

        try:
            item_note = item_data['note']
            query_string = "SELECT `note` FROM `itemNotes` " + \
                           "WHERE `hash` = %s " + \
                           "ORDER BY `noteDate` DESC " + \
                           "LIMIT 1"
            query_values = (item_hash,)

            last_note = self.database.query(
                query_string,
                query_values).fetchone()

            if last_note is None or \
                    last_note[0] != item_note:
                query_string = "INSERT INTO `itemNotes` " + \
                               "(`hash`, `note`) " + \
                               "VALUES (%s, %s) "
                query_values = (item_hash, item_note)
                self.database.query(query_string, query_values)
        except KeyError:
            pass
