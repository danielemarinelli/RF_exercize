*** Settings ***
Documentation     All the page objects and keywords of confirmation page
Library           SeleniumLibrary
Resource           TestBase.robot


*** Variables ***
${Shop_page_load}           css:.nav-link
#${country_location}         //a[text()='Italy']



*** Keywords ***

Enter the Country and select the terms
    [Arguments]      ${country_name}
    input text      country     ${country_name}
    Wait until element passed is displayed in the page       //a[text()='${country_name}']
    click element       //a[text()='${country_name}']
    Sleep           2
    click element       css:.checkbox label


Purchase the Product and Confirm the Purchase
    click button    css:.btn-success
    page should contain     Success!





