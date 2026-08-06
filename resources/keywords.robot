*** Settings ***
Library    SeleniumLibrary

Resource    variables.robot
Resource    locators.robot


*** Keywords ***

Open Application
    Open Browser    ${BASE_URL}    edge
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}

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

Verify Login Successful
    Wait Until Element Is Visible    ${PRODUCT_TITLE}
    Element Text Should Be    ${PRODUCT_TITLE}    Products

Verify Login Failed
    Wait Until Element Is Visible    ${ERROR_MESSAGE}

Add Backpack To Cart
    Click Button    ${ADD_BACKPACK}

Verify Cart Badge
    [Arguments]    ${count}
    Element Text Should Be    ${CART_BADGE}    ${count}

Open Shopping Cart
    Click Element    ${SHOPPING_CART}

Verify Item Exists In Cart
    Wait Until Element Is Visible    ${CART_ITEM}

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