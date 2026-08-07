*** Settings ***
Resource    ../resources/keywords.robot

Suite Setup       Open Application
Suite Teardown    Close Application
Test Setup        Go To Login Page

*** Test Cases ***

Valid Login
    Login    ${VALID_USER}    ${VALID_PASSWORD}
    Verify Login Successful

Locked User Login
    Login    ${LOCKED_USER}    ${VALID_PASSWORD}
    Verify Login Failed    locked out

Invalid Credentials Login
    [Documentation]    Data-driven case: credentials are loaded from
    ...                testdata/users.json instead of variables.robot.
    Login As User Type    invalid
    Verify Login Failed    do not match

Empty Username
    Login    ${EMPTY}    ${VALID_PASSWORD}
    Verify Login Failed    Username is required

Empty Password
    Login    ${VALID_USER}    ${EMPTY}
    Verify Login Failed    Password is required
