*** Settings ***
Library     Collections
# API library is --->  https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html
Library    RequestsLibrary

*** Variables ***
${BaseURL}    http://216.10.245.166
${book_ID}
${book_name}    JavaLearning


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
#https://drive.google.com/file/d/18FC3jDnsOol9zn3_KGSrjg35a4unpiSG/view?pli=1
#{
#name:Learn Appium Automation with Java,
#isbn:bcd,
#aisle:227,
#author:John foe,
#}
    &{payload_body}=    Create Dictionary    name=${book_name}    isbn=1299148    aisle=3888928   author=Dan Brown
    ${response}=    POST    ${BaseURL}/Library/Addbook.php    json=${payload_body}    expected_status=200
    Log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    ID
    ${book_ID}=    Get From Dictionary    ${response.json()}    ID
    Log    ${book_ID}
    ${msg}=    Get From Dictionary    ${response.json()}    Msg
    Should Be Equal    ${msg}    successfully added
    #same validation in one row:
    Should Be Equal As Strings    ${response.json()}[Msg]    successfully added
    Status Should Be    200    ${response}
    Set Global Variable    ${book_ID}  #when setting a variable to Global, must insert it even in the VARIABLE section of .robot file

Get the book details that was added in the previous test
    ${get_response}=    GET    ${BaseURL}/Library/GetBook.php    params=ID=${book_ID}    expected_status=200
    Log    ${get_response.json()}
     #the response is wrapped into [], so it is a LIST of dictionaries.
    #in this example there is one dictionary only with index 0
    Should Be Equal As Strings    ${book_name}      ${get_response.json()}[0][book_name]



#Get all books
#    ${get_response}=    GET    ${BaseURL}/Library/GetBook.php    expected_status=200
#    Log    ${get_response.json()}


Delete book from database
    &{delete_book}=    Create Dictionary    ID=${book_id}
    ${delete_resp}=    POST    ${BaseURL}/Library/DeleteBook.php    json=${delete_book}    expected_status=200
    Log    ${delete_resp.json()}
    Should Be Equal As Strings    book is successfully deleted      ${delete_resp.json()}[msg]
    
    