*** Settings ***
Documentation      All the pages objects and keywords of landing page
Library            SeleniumLibrary
Library            Collections

*** Variables ***
${Shop_page_Loaded}               css:.my-4

*** Keywords ***

Be patient waiting till the element is visible
    Wait Until Element Is Visible    ${Shop_page_Loaded}


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



