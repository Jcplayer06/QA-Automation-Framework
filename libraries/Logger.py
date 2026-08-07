"""
Thin wrapper around Robot Framework's built-in logger.

Exists so test-level keywords and other custom libraries can log
messages without importing `robot.api.logger` directly everywhere,
and so logging behavior (e.g. writing to an external file) can be
extended in one place later without touching call sites.
"""

from robot.api import logger


class Logger:
    """Provides simple info/warn/error logging for use in .robot files."""

    def info(self, message):
        """Log an informational message to the Robot Framework log."""
        logger.info(message)

    def warn(self, message):
        """Log a warning message to the Robot Framework log."""
        logger.warn(message)

    def error(self, message):
        """Log an error message to the Robot Framework log."""
        logger.error(message)
