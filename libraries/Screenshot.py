"""
Thin wrapper around Robot Framework/SeleniumLibrary's screenshot
capture, exposed as a standalone keyword so it can be called
consistently from any test suite (e.g. on failure or at key
checkpoints) without repeating the raw "Capture Page Screenshot"
keyword name throughout the .robot files.
"""

from robot.libraries.BuiltIn import BuiltIn


class Screenshot:
    """Captures a screenshot of the current browser page."""

    def capture(self):
        """Capture a screenshot via SeleniumLibrary's built-in keyword."""
        BuiltIn().run_keyword("Capture Page Screenshot")
