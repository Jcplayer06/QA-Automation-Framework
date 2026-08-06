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