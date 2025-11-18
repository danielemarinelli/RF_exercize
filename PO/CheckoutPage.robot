*** Settings ***
Documentation      All the pages objects and keywords of landing page
Library            SeleniumLibrary
Library            Collections
Resource           TestBase.robot


*** Variables ***
${Shop_page_Loaded}               css:.my-4

*** Keywords ***
Verify items in the checkout page and proceed
    Click Element    css:.btn-success



