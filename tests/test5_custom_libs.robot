*** Settings ***
Documentation    To validate the Login form and Select a product
Library    SeleniumLibrary
Library           Collections
Test Setup       open the browser with the payment url     # similar to @BeforeTest
Test Teardown    Close Browser webpage session             # similar to @AfterTest
Resource    resource.robot
# Import the Custom Library created in the python file
Library    ../customLibrary/Shop.py


*** Variables ***
${Error_Message_Displayed}        css:.alert-danger
${Shop_page_Loaded}               css:.my-4
${User_radioButton}               xpath:(//span[@class='checkmark'])[2]
# creating one list variable:
@{listOfProducts}                 Blackberry    Nokia Edge




*** Test Cases ***
#Customize keywords in the test cases
TC001_Validate UnSuccessful Login
    
    fill the login form    ${user_name}    ${wrong_pw}
    Be patient waiting till the element is visible    ${Error_Message_Displayed}
    verify error message is correct

TC002_Validate Cards display in the Shopping page
    fill the login form    ${user_name}    ${valid_pw}
    Be patient waiting till the element is visible    ${Shop_page_Loaded}
    Verify all the products displayed in the shopping page
    Example Custom Keyword Hello World
    #we want to select more products, not only Blackberry, so let's create a customize keywork with a list of products as argument
    #Select a product from the web page    Blackberry
    Add Items To Cart And Checkout        ${listOfProducts}
    Sleep    5

TC003_Select the Form and navigate to child window
    Fill the login details and login form    ${user_name}    ${valid_pw}



*** Keywords ***


fill the login form
    [Arguments]    ${user}    ${password}
    Input Text        id:username    ${user}
    Input Password    id:password    ${password}
    Click Button      id:signInBtn



Be patient waiting till the element is visible
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}

verify error message is correct
    ${msg_display} =     Get Text    ${Error_Message_Displayed}
    Should Be Equal As Strings    ${msg_display}    Incorrect username/password.

    Element Text Should Be    ${Error_Message_Displayed}    Incorrect username/password.
    
Verify all the products displayed in the shopping page

    @{expected_list}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${web_elements}=    Get Webelements    css:.card-title
    @{actual_list}=    Create List    #creates an empty list
    
    FOR    ${we}    IN    @{web_elements}
        Log    ${we.text}
        Append To List    ${actual_list}    ${we.text}
    END


    Lists Should Be Equal    ${actual_list}    ${expected_list}

Select a product from the web page
    [Arguments]    ${productName}
    ${web_elements}=    Get Webelements    css:.card-title
    ${index}=    Set Variable    1
    FOR    ${we}    IN    @{web_elements}

         Exit For Loop If    '${productName}' == '${we.text}'
            ${index}=    Evaluate    ${index}+1
    END
    Click Button    xpath:(//div[@class='card-footer'])[${index}]/button

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

    
