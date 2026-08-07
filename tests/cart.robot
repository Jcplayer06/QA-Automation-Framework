*** Settings ***
Resource    ../resources/keywords.robot

Suite Setup       Open Application
Suite Teardown    Close Application
Test Setup        Go To Login Page

*** Test Cases ***

Add And Remove Backpack
    Login    ${VALID_USER}    ${VALID_PASSWORD}
    Verify Login Successful

    Add Backpack To Cart
    Verify Cart Badge    1

    Open Shopping Cart
    Verify Item Exists In Cart

    Remove Backpack
    Verify Cart Badge Not Present

Add Multiple Items To Cart
    [Documentation]    Covers a gap the AI stability report flags:
    ...                the original suite only ever added one item.
    Login    ${VALID_USER}    ${VALID_PASSWORD}
    Verify Login Successful

    Add Backpack To Cart
    Add Bike Light To Cart
    Verify Cart Badge    2

    Open Shopping Cart
    Verify Number Of Items In Cart    2