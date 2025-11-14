*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Test Setup       open the browser with the payment url     # similar to @BeforeTest
Test Teardown    Close Browser webpage session             # similar to @AfterTest
Resource    resource.robot


*** Variables ***
${Error_Message_Displayed}        css:.alert-danger
${Shop_page_Loaded}               css:.my-4

*** Test Cases ***
#Customize keywords in the test cases
Validate UnSuccessful Login
    
    fill the login form    ${user_name}    ${wrong_pw}
    Be patient waiting till the element is visible    ${Error_Message_Displayed}
    verify error message is correct

Validate Cards display in the Shopping page
    fill the login form    ${user_name}    ${valid_pw}
    Be patient waiting till the element is visible    ${Shop_page_Loaded}
    Verify all the products displayed in the shopping page

*** Keywords ***
#Here insert the selenium library keywords needed

fill the login form
    [Arguments]    ${user}    ${password}
    Input Text        id:username    ${user}
    Input Password    id:password    ${password}
    Click Button      id:signInBtn

#wait until it checks and display error message
#    Wait Until Element Is Visible    ${Error_Message_Displayed}

Be patient waiting till the element is visible
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}

verify error message is correct
    ${msg_display} =     Get Text    ${Error_Message_Displayed}
    Should Be Equal As Strings    ${msg_display}    Incorrect username/password.
    #the two lines above can be wrapped in this single line below:
    Element Text Should Be    ${Error_Message_Displayed}    Incorrect username/password.
    
Verify all the products displayed in the shopping page
    # the below keyword (create list) comes from Build-In library
    @{expected_list}=    Create List    iphone X    Samsung 8    Nokia Edge    Blackberry
    ${web_elements}=    Get Webelements    css:.card-title
    FOR    ${we}    IN    @{web_elements}
        Log    ${we.text}    # print in the output log.html file
    END


