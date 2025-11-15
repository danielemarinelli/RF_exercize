*** Settings ***
Documentation    To validate the switch windows feature
Library    SeleniumLibrary
Library           Collections
Library    String
Test Setup       open the browser with the payment url     # similar to @BeforeTest
Test Teardown    Close Browser webpage session             # similar to @AfterTest
Resource    resource.robot

*** Variables ***



*** Test Cases ***
T004_Validate child window functionality
    Select the link in the upright corner of the webpage
    Verify the user switched to child window
    Grab the email displayed in the child window
    Switch to Parent window and enter the email

*** Keywords ***
Select the link in the upright corner of the webpage
    Click Element    css:.blinkingText
    Sleep    5        # let's wait that the child windows loads

Verify the user switched to child window
    Switch Window    NEW
    Element Text Should Be    css:h1    DOCUMENTS REQUEST

Grab the email displayed in the child window
    ${textDisplayed}=    Get Text    xpath://p[@class='im-para red']
    #there is new library STRING to deal with strings, must be imported
    @{list_of_substrings}=    Split String    ${textDisplayed}    at        # Spltting the entire string in two parts. AT word is the separator. Returns a list with indexes
    #index 0 has stored this part of the string -> Please email us
    #index 1 has stored this part of the string -> mentor@rahulshettyacademy.com  with below template to receive response

    ${text_split}=    Get From List    ${list_of_substrings}    1    #get substring with index 1
    Log    ${text_split}
    #splitting again the sentence with index=1 , NOTE: the separator this time is SPACE, so no argument is needed
    # will split the string considering all white spaces:
    @{words}=    Split String    ${text_split}
    #index 0 has the email
    ${email}=    Get From List    ${words}    0    #this variable contains the email displayed
    Set Global Variable    ${email}

Switch to Parent window and enter the email
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text        id:username    ${email}
    Sleep    3
    
    