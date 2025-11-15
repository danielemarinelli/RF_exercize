*** Settings ***
Documentation    To validate the Login form
Library    SeleniumLibrary
Library           Collections
Test Setup       open the browser with the payment url     # similar to @BeforeTest
Test Teardown    Close Browser webpage session             # similar to @AfterTest
Resource    resource.robot


*** Variables ***
${Error_Message_Displayed}        css:.alert-danger
${Shop_page_Loaded}               css:.my-4
${User_radioButton}               xpath:(//span[@class='checkmark'])[2]

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
    Select a product from the web page    Blackberry

TC003_Select the Form and navigate to child window
    Fill the login details and login form    ${user_name}    ${valid_pw}



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
    # when creating a list for first time use @{} symbol
    @{expected_list}=    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${web_elements}=    Get Webelements    css:.card-title
    @{actual_list}=    Create List    #creates an empty list
    
    FOR    ${we}    IN    @{web_elements}
        Log    ${we.text}    # print in the output log.html file
        # the below keyword (append to list) comes from Collection library
        Append To List    ${actual_list}    ${we.text}
    END

    #compare the two lists, keyword from Collection library
    Lists Should Be Equal    ${actual_list}    ${expected_list}

Select a product from the web page
    [Arguments]    ${productName}
    ${web_elements}=    Get Webelements    css:.card-title
    ${index}=    Set Variable    1
    FOR    ${we}    IN    @{web_elements}
        #iterating the products to find the name I selected
         Exit For Loop If    '${productName}' == '${we.text}'
            ${index}=    Evaluate    ${index}+1
    END
    Click Button    xpath:(//div[@class='card-footer'])[${index}]/button

Fill the login details and login form
    [Arguments]    ${user}    ${password}
    Input Text        id:username    ${user}
    Input Password    id:password    ${password}
    # how to handle radio buttons (keyword in SeleniumLibrary)
    Click Element    ${User_radioButton}
    Wait Until Element Is Visible    okayBtn   # inserted only the id of element to locate, without 'id:' in front (with ID it's allowed)
    Click Button    css:#okayBtn
    Wait Until Element Is Not Visible    okayBtn
    # how to handle drop downs (keyword in SeleniumLibrary)
    Select From List By Label    css:.form-group select    Teacher
    # how to handle checkbox  (keyword in SeleniumLibrary)
    Select Checkbox    css:#terms
    Checkbox Should Be Selected    terms   #word terms -> is the ID


    
