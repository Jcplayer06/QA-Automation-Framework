*** Settings ***
Resource    ../resources/keywords.robot

Suite Setup       Open Application
Suite Teardown    Close Application
Test Setup        Go To Login Page


*** Test Cases ***

Invalid Login
    Login    ${INVALID_USER}    ${INVALID_PASSWORD}
    Wait Until Element Is Visible    ${ERROR_MESSAGE}

Successful Login
    Login    ${VALID_USER}    ${VALID_PASSWORD}
    Wait Until Element Is Visible    ${PRODUCT_TITLE}