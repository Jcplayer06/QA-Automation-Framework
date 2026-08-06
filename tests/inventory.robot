*** Settings ***
Resource    ../resources/keywords.robot

Suite Setup       Open Application
Suite Teardown    Close Application
Test Setup        Go To Login Page

*** Test Cases ***

Inventory Page Loads
    Login    ${VALID_USER}    ${VALID_PASSWORD}
    Verify Login Successful

Backpack Is Visible
    Login    ${VALID_USER}    ${VALID_PASSWORD}
    Wait Until Element Is Visible    ${BACKPACK}