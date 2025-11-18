*** Settings ***
Library     Collections

*** Test Cases ***

Understand and play with Dictionary
    &{data}=     Create Dictionary    name=Daniele    course=robot    job=QA
    Log        ${data}
    Dictionary Should Contain Key    ${data}    name
    Log    ${data}[name]
    ${role}=    Get From Dictionary    ${data}    job
    Log    ${role}







