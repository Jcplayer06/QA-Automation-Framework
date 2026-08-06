*** Settings ***
Library    SeleniumLibrary

Resource    variables.robot
Resource    locators.robot


*** Keywords ***

Open Application
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    ${prefs}=    Create Dictionary
    ...    credentials_enable_service=False
    ...    profile.password_manager_enabled=False

    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Call Method    ${options}    add_argument    --start-maximized

    Open Browser
    ...    ${BASE_URL}
    ...    chrome
    ...    options=${options}

    Set Selenium Timeout    ${TIMEOUT}

Close Application
    Close Browser

Go To Login Page
    Go To    ${BASE_URL}

Login
    [Arguments]    ${username}    ${password}

    Wait Until Element Is Visible    ${USERNAME_INPUT}
    Input Text        ${USERNAME_INPUT}    ${username}
    Input Password    ${PASSWORD_INPUT}    ${password}
    Click Button      ${LOGIN_BUTTON}

Add Backpack To Cart
    Click Button    ${ADD_BACKPACK}

Open Shopping Cart
    Click Element    ${SHOPPING_CART}

Verify Cart Badge
    [Arguments]    ${expected}

    Element Text Should Be
    ...    ${CART_BADGE}
    ...    ${expected}

Verify Item Exists In Cart
    Wait Until Element Is Visible    ${CART_ITEM}

Proceed To Checkout
    Click Button    ${CHECKOUT_BUTTON}

Fill Checkout Information
    [Arguments]    ${firstname}    ${lastname}    ${zipcode}

    Input Text    ${FIRST_NAME}    ${firstname}
    Input Text    ${LAST_NAME}     ${lastname}
    Input Text    ${ZIP_CODE}      ${zipcode}

    Click Button    ${CONTINUE_BUTTON}

Finish Checkout
    Click Button    ${FINISH_BUTTON}

Verify Successful Checkout
    Wait Until Element Is Visible    ${SUCCESS_MESSAGE}

    Element Text Should Be
    ...    ${SUCCESS_MESSAGE}
    ...    Thank you for your order!