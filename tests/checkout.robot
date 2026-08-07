*** Settings ***
Resource    ../resources/keywords.robot

Suite Setup       Open Application
Suite Teardown    Close Application
Test Setup        Go To Login Page

*** Test Cases ***

Complete Checkout
    Login    ${VALID_USER}    ${VALID_PASSWORD}
    Verify Login Successful

    Add Backpack To Cart
    Open Shopping Cart
    Verify Item Exists In Cart

    Proceed To Checkout
    Fill Checkout Information    Joshua    Carbon    1000
    Finish Checkout

    Verify Successful Checkout

Checkout Rejected When Zip Code Missing
    [Documentation]    Edge case: SauceDemo requires all three checkout
    ...                fields; submitting without a zip code must block
    ...                the order instead of silently proceeding.
    Login    ${VALID_USER}    ${VALID_PASSWORD}
    Verify Login Successful

    Add Backpack To Cart
    Open Shopping Cart
    Verify Item Exists In Cart

    Proceed To Checkout
    Fill Checkout Information    Joshua    Carbon    ${EMPTY}

    Verify Checkout Rejected    Postal Code is required
