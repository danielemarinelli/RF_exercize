*** Settings ***
Documentation    All the pages objects and keywords of landing page
Library    SeleniumLibrary

*** Variables ***
${Error_Message_Displayed}        css:.alert-danger

*** Keywords ***

fill the login form
    [Arguments]    ${user}    ${password}
    Input Text        id:username    ${user}
    Input Password    id:password    ${password}
    Click Button      id:signInBtn

Be patient waiting till the element is visible
    Wait Until Element Is Visible    ${Error_Message_Displayed}


verify error message is correct
    ${msg_display} =     Get Text    ${Error_Message_Displayed}
    Should Be Equal As Strings    ${msg_display}    Incorrect username/password.

    Element Text Should Be    ${Error_Message_Displayed}    Incorrect username/password.


Fill the login details and login form
    [Arguments]    ${user}    ${password}
    Input Text        id:username    ${user}
    Input Password    id:password    ${password}

    Click Element    ${User_radioButton}
    Wait Until Element Is Visible    okayBtn
    Click Button    css:#okayBtn
    Wait Until Element Is Not Visible    okayBtn

    Select From List By Label    css:.form-group select    Teacher

    Select Checkbox    css:#terms
    Checkbox Should Be Selected    terms
    Sleep    3