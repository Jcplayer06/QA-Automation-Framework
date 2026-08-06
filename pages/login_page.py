from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC


class LoginPage:
    """
    Page Object for the SauceDemo Login Page.
    Handles all interactions related to logging in.
    """

    # ---------- Locators ----------
    USERNAME_INPUT = (By.ID, "user-name")
    PASSWORD_INPUT = (By.ID, "password")
    LOGIN_BUTTON = (By.ID, "login-button")
    ERROR_MESSAGE = (By.CSS_SELECTOR, "h3[data-test='error']")

    def __init__(self, browser):
        self.driver = browser.get_driver()
        self.wait = browser.get_wait()

    # ---------- Actions ----------

    def enter_username(self, username):
        username_field = self.wait.until(
            EC.visibility_of_element_located(self.USERNAME_INPUT)
        )
        username_field.clear()
        username_field.send_keys(username)

    def enter_password(self, password):
        password_field = self.driver.find_element(*self.PASSWORD_INPUT)
        password_field.clear()
        password_field.send_keys(password)

    def click_login(self):
        self.driver.find_element(*self.LOGIN_BUTTON).click()

    def login(self, username, password):
        self.enter_username(username)
        self.enter_password(password)
        self.click_login()

    def get_error_message(self):
        return self.wait.until(
            EC.visibility_of_element_located(self.ERROR_MESSAGE)
        ).text