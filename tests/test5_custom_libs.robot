*** Settings ***
Documentation    To validate the Login form and Select a product
Library    SeleniumLibrary
Library           Collections
Test Setup       open the browser with the payment url     # similar to @BeforeTest
Test Teardown    Close Browser webpage session             # similar to @AfterTest
Resource    ../PO/TestBase.robot
# Import the Custom Library created in the python file
Library    ../customLibrary/Shop.py
Resource    ../PO/LandingPage.robot
Resource    ../PO/ShopPage.robot
Resource    ../PO/CheckoutPage.robot

*** Variables ***

${User_radioButton}               xpath:(//span[@class='checkmark'])[2]
# creating one list variable:
@{listOfProducts}                 Blackberry    Nokia Edge


*** Test Cases ***
#Customize keywords in the test cases
TC001_Validate UnSuccessful Login
    
    LandingPage.fill the login form    ${user_name}    ${wrong_pw}
    LandingPage.Be patient waiting till the element is visible
    LandingPage.verify error message is correct

TC002_Validate Cards display in the Shopping page
    LandingPage.fill the login form    ${user_name}    ${valid_pw}
    ShopPage.Be patient waiting till the element is visible
    ShopPage.Verify all the products displayed in the shopping page
    Example Custom Keyword Hello World
    Add Items To Cart And Checkout        ${listOfProducts}
    CheckoutPage.Verify items in the checkout page and proceed


TC003_Select the Form and navigate to child window
    LandingPage.Fill the login details and login form    ${user_name}    ${valid_pw}



*** Keywords ***








    
