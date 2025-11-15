*** Settings ***
Documentation    A resource file with reusable keywords and variables
Library    SeleniumLibrary


*** Variables ***
${user_name}    rahulshettyacademy
${wrong_pw}    myPass123
${valid_pw}    learning
${URL}        http://www.rahulshettyacademy.com/loginpagePractise/

*** Keywords ***
#insert the navigate to website in the resource file, so all tests use it without repeating it in all test cases
open the browser with the payment url
    Create Webdriver    Chrome
    Go To    ${URL}
    Maximize Browser Window

Close Browser webpage session
    Close Browser