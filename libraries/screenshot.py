from robot.libraries.BuiltIn import BuiltIn

class Screenshot:

    def capture(self):
        BuiltIn().run_keyword("Capture Page Screenshot")