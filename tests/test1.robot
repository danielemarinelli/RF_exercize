*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Test Teardown


*** Test Cases ***
#Customize keywords in the test cases
Validate UnSuccessful Login
    open the browser with the payment url
    fill the login form
    wait until it checks and display error message
    verify error message is correct

*** Keywords ***
#Here insert the selenium library keywords needed
open the browser with the payment url
    Create Webdriver    Chrome
    Go To    http://www.rahulshettyacademy.com/loginpagePractise/

fill the login form
    Input Text        id:username    dmarinel
    Input Password    id:password    myPass123
    Click Button      id:signInBtn    

wait until it checks and display error message
    Wait Until Element Is Visible    css:.alert-danger

verify error message is correct
    ${msg_display} =     Get Text    css:.alert-danger
    Should Be Equal As Strings    ${msg_display}    Incorrect username/password.