"""
Provides an abstract class for database operations.
"""

import abc

class Database:
    """
    Abstract class for a database.
    """
    @abc.abstractmethod
    def connect(self):
        """
        Opens a connection to the database.
        """
        return

    @abc.abstractmethod
    def disconnect(self):
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
    def query(self, query_string, query_values):
        """
        Sends a query to the database.
        Returns the result.
        """
        return
