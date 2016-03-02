"""
Provides an abstract class for database operations.
"""

import abc

class Database:
    @abc.abstractmethod
    def _connect(self):
        """
        Opens a connection to the database.
        """
        return

    @abc.abstractmethod
    def _disconnect(self):
        """
        Closes a connection to the database.
        """
        return

    @abc.abstractmethod
    def commit(self):
        """
        Commits a transaction to the database.
        """
        return

    @abc.abstractmethod
    def query(self, query_string):
        """
        Sends a query to the database.
        Returns the result.
        """
        return
