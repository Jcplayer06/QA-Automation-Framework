*** Settings ***
Library    SeleniumLibrary
Library    ../libraries/Logger.py           WITH NAME    Log
Library    ../libraries/Screenshot.py       WITH NAME    Shot
Library    ../libraries/TestDataReader.py   WITH NAME    TestData

Resource    variables.robot
Resource    locators.robot


*** Keywords ***

Open Application
    Open Browser    ${BASE_URL}    edge
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}
    Log.Info    Opened browser and navigated to ${BASE_URL}

Close Application
    Close Browser

Go To Login Page
    Go To    ${BASE_URL}

Login
    [Arguments]    ${username}    ${password}

    Wait Until Element Is Visible    ${USERNAME_INPUT}

    Clear Element Text    ${USERNAME_INPUT}
    Clear Element Text    ${PASSWORD_INPUT}

    Input Text        ${USERNAME_INPUT}    ${username}
    Input Password    ${PASSWORD_INPUT}    ${password}

    Click Button      ${LOGIN_BUTTON}
    Log.Info    Submitted login form for user: ${username}

Login As User Type
    [Documentation]    Logs in using credentials loaded from testdata/users.json
    ...                instead of hardcoded values. user_type is one of:
    ...                valid, locked, invalid.
    [Arguments]    ${user_type}
    ${username}=    TestData.Get Username    ${user_type}
    ${password}=    TestData.Get Password    ${user_type}
    Login    ${username}    ${password}

Verify Login Successful
    Wait Until Element Is Visible    ${PRODUCT_TITLE}
    Element Text Should Be    ${PRODUCT_TITLE}    Products

Verify Login Failed
    [Arguments]    ${expected_text}=${EMPTY}
    Verify Error Message    ${ERROR_MESSAGE}    ${expected_text}
    Log.Warn    Login failed as expected, screenshot captured

Add Backpack To Cart
    Click Button    ${ADD_BACKPACK}

Add Bike Light To Cart
    Click Button    ${ADD_BIKE_LIGHT}

Verify Cart Badge
    [Arguments]    ${count}
    Element Text Should Be    ${CART_BADGE}    ${count}

Verify Cart Badge Not Present
    Element Should Not Be Visible    ${CART_BADGE}

Open Shopping Cart
    Click Element    ${SHOPPING_CART}

Verify Item Exists In Cart
    Wait Until Element Is Visible    ${CART_ITEM}

Verify Number Of Items In Cart
    [Arguments]    ${count}
    ${items}=    Get WebElements    ${CART_ITEM}
    Length Should Be    ${items}    ${count}

Remove Backpack
    Click Button    ${REMOVE_BACKPACK}
    Wait Until Element Is Not Visible    ${REMOVE_BACKPACK}

Proceed To Checkout
    Click Button    ${CHECKOUT_BUTTON}

Fill Checkout Information
    [Arguments]    ${firstname}    ${lastname}    ${zipcode}

    Input Text    id:first-name    ${firstname}
    Input Text    id:last-name     ${lastname}
    Input Text    id:postal-code   ${zipcode}

    Click Button    id:continue

Finish Checkout
    Click Button    ${FINISH_BUTTON}

Verify Successful Checkout
    Wait Until Element Is Visible    ${SUCCESS_MESSAGE}
    Element Text Should Be
    ...    ${SUCCESS_MESSAGE}
    ...    Thank you for your order!

Verify Checkout Rejected
    [Documentation]    Confirms SauceDemo blocks checkout when a
    ...                required field (first name, last name, or
    ...                zip code) is missing, and reports which field.
    [Arguments]    ${expected_text}=${EMPTY}
    Verify Error Message    ${CHECKOUT_ERROR}    ${expected_text}

Verify Error Message
    [Documentation]    Shared assertion used by both login and checkout
    ...                error cases: waits for the error element, captures
    ...                a screenshot, and optionally checks its text.
    [Arguments]    ${locator}    ${expected_text}=${EMPTY}
    Wait Until Element Is Visible    ${locator}
    Shot.Capture
    IF    '${expected_text}' != '${EMPTY}'
        Element Should Contain    ${locator}    ${expected_text}
    END