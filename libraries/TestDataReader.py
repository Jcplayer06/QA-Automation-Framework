"""
Loads test user credentials from testdata/users.json so login
scenarios are data-driven instead of hardcoded across .robot files.
"""

import json
from pathlib import Path


class TestDataReader:
    """Reads user credential sets from the shared testdata JSON file."""

    def __init__(self):
        self._data_file = Path(__file__).parent.parent / "testdata" / "users.json"
        with open(self._data_file, "r", encoding="utf-8") as f:
            self._data = json.load(f)

    def get_username(self, user_type):
        """
        Args:
            user_type: one of "valid", "locked", "invalid" (see users.json)
        Returns:
            The username string for that user type.
        """
        return self._data[user_type]["username"]

    def get_password(self, user_type):
        """
        Args:
            user_type: one of "valid", "locked", "invalid" (see users.json)
        Returns:
            The password string for that user type.
        """
        return self._data[user_type]["password"]