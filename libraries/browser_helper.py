from selenium import webdriver
from selenium.webdriver.chrome.options import Options


class BrowserHelper:
    """
    Reusable browser helper for Robot Framework.
    Handles opening and closing the browser.
    """

    def open_browser(self, url):
        options = Options()
        options.add_argument("--start-maximized")

        self.driver = webdriver.Chrome(options=options)
        self.driver.get(url)

        return self.driver

    def close_browser(self):
        if hasattr(self, "driver"):
            self.driver.quit()

    def get_driver(self):
        return self.driver