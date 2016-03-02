"""
Provides a class for a connection to a MySQL Database.
"""

import MySQLdb as mdb

from Database import Database

class MySQLDatabase(Database):
    """
    Creates a connection to a MySQL Database.
    """
    def __init__(self, host, user, password, database):
        self.host = host
        self.user = user
        self.password = password
        self.database = database
        self.connect()

    def connect(self):
        self.connection = mdb.connect(
            self.host,
            self.user,
            self.password,
            self.database)
        self.cursor = self.connection.cursor()

    def disconnect(self):
        self.connection.close()

    def commit(self):
        self.cursor.close()
        self.connection.commit()

    def query(self, query_string, query_values=None):
        if query_values:
            self.cursor.execute(query_string, query_values)
        else:
            self.cursor.execute(query_string)
        return self.cursor

    @property
    def last_insert_id(self):
        """
        Returns the last inserted ID.
        """
        return self.cursor.lastrowid
