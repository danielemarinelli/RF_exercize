*** Settings ***
Documentation    To validate Wrong login credentials with different dataset (TDD)
Library    SeleniumLibrary
Test Teardown    Close Browser
Test Template    TC005_Validate UnSuccessful Login

*** Variables ***
${Error_Message_Displayed}        css:.alert-danger

# different dataset as credentials under TestCase
*** Test Cases ***        username    password
Invalid UserName          dmarinel    learning      
Invalid Password          rahulshettyacademy    badpwss      
Special Characters        @?}%$}      learning


*** Keywords ***
# The TC goes under KEYWORDS section and insert Arguments.
# In settings section remember to insert TEST TEMPLATE to perform TDD
TC005_Validate UnSuccessful Login
    [Arguments]    ${user}    ${password}
    open the browser with the payment url
    fill the login form    ${user}    ${password}
    wait until it checks and display error message
    verify error message is correct

#Here insert the selenium library keywords needed
open the browser with the payment url
    Create Webdriver    Chrome
    Go To    http://www.rahulshettyacademy.com/loginpagePractise/

fill the login form
    [Arguments]    ${user}    ${password}
    Input Text        id:username    ${user}
    Input Password    id:password    ${password}
    Click Button      id:signInBtn

wait until it checks and display error message
    Wait Until Element Is Visible    ${Error_Message_Displayed}

verify error message is correct
    ${msg_display} =     Get Text    ${Error_Message_Displayed}
    Should Be Equal As Strings    ${msg_display}    Incorrect username/password.
    #the two lines above can be wrapped in this single line below:
    Element Text Should Be    ${Error_Message_Displayed}    Incorrect username/password.


