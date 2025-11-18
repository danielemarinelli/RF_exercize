*** Settings ***
Library     Collections
# API library is --->  https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html
Library    RequestsLibrary

*** Variables ***
${BaseURL}    http://216.10.245.166



*** Test Cases ***

Understand and play with Dictionary
    &{data}=     Create Dictionary    name=Daniele    course=robot    job=QA
    Log        ${data}
    Dictionary Should Contain Key    ${data}    name
    Log    ${data}[name]
    ${role}=    Get From Dictionary    ${data}    job
    Log    ${role}


Add book into library database
#from swagger docs, this is the payload to send:
#{
#name:Learn Appium Automation with Java,
#isbn:bcd,
#aisle:227,
#author:John foe,
#}
    &{payload_body}=    Create Dictionary    name=RobotFramework    isbn=59993    aisle=01102    author=Dan Brown
    POST    ${BaseURL}/Library/Addbook.php    json=${payload_body}    expected_status=200






