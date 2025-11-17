*** Settings ***
Documentation    To validate Wrong login credentials with different dataset (TDD)
Library    SeleniumLibrary
Test Teardown    Close Browser
Test Template    TC005_Validate UnSuccessful Login
# NB: -->> Need to install library: robotframework-datadriver  --> pip install robotframework-datadriver
#Import the DataDriver library an point to the .csv file, with two optional arguments:
Library    DataDriver    file=resources/dataset.csv    encoding=utf_8    dialect=unix


*** Variables ***
${Error_Message_Displayed}        css:.alert-danger


*** Test Cases ***
#insert a generic sentence, specify at the end defaultUser and defaultPassword, if the file is corrupted or not found:
Login with user ${user} and password ${password} from an external file        defaultUser    defaultPassword

*** Keywords ***
# The TC goes under KEYWORDS section and insert Arguments.
# In settings section remember to insert TEST TEMPLATE to perform TDD
TC005_Validate UnSuccessful Login
    [Arguments]    ${user}    ${password}   #NB these two arguments should be exact and match to the columns headers of the csv file
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


