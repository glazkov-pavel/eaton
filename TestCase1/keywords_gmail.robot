*** Settings ***
Library           SeleniumLibrary

*** Keywords ***
Open Browser To Gmail
    Open Browser    https://mail.google.com    chrome
    Maximize Browser Window

Login To Gmail
    [Documentation]    Logs in to Gmail
    Input Text    id=identifierId    ${EMAIL}
    Click Button    xpath=//button[@type='button' and contains(.,'Next')]
    Sleep    7s
    Input Text    name=Passwd    ${PASSWORD}
    Click Button    xpath=//button[@type='button' and contains(.,'Next')]
    Sleep    10s

Compose And Send Email With Label
    [Documentation]    Composes an email with a label and sends it to the given email
    Click Element    xpath=//div[@role='button' and contains(.,'Compose')]
    Sleep    2s
    Input Text    xpath=//input[@aria-label='To recipients']    ${EMAIL}
    Input Text    name=subjectbox    ${SUBJECT}
    Input Text    xpath=//div[@aria-label='Message Body']    ${BODY}
    Click Element    xpath=//div[@aria-label='More options']
    Click Element    xpath=//div[contains(text(),'Label')]
    Sleep    2s
    Click Element    xpath=//div[contains(text(),'${LABEL}')]
    Sleep    2s
    # Click Element    xpath=//div[contains(text(),'Apply')]
    Execute JavaScript    document.evaluate("//div[contains(text(),'Apply')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();
    Sleep    2s
    Click Element    xpath=//div[@role='button' and contains(.,'Send')]
    Sleep    5s

Wait For Email And Verify
    [Documentation]    Waits for the email to arrive, marks it as starred, and verifies the data
    Wait For Email In Inbox
    Open and Mark Email As Starred
    Verify Email

Wait For Email In Inbox
    [Documentation]    Waits for the email to arrive in the inbox
    Click Element    xpath=//a[contains(text(), 'Inbox')]
    Wait Until Page Contains Element    xpath=//span[contains(text(),'${SUBJECT}')]

Open and Mark Email As Starred
    [Documentation]    Opens the email and marks as starred
    Click Element    xpath=(//span[contains(text(),'${SUBJECT}')])[2]
    Sleep    2s
    Click Element    xpath=//div[@aria-label='Not starred']

Verify Email
    [Documentation]    Verifies the label, subject, and body
    # Click Element    xpath=//span[contains(text(),'${SUBJECT}')]
    ${email_subject}=    Get Text    xpath=//h2[contains(text(),'${SUBJECT}')]
    Should Be Equal    ${SUBJECT}    ${email_subject}
    ${email_body}=    Get Text    xpath=//div[@dir='ltr'][contains(text(),'${BODY}')]
    Should Be Equal    ${BODY}    ${email_body}
    Click Element    xpath=(//div[@aria-label='More email options'])[2]
    Click Element    xpath=//div[contains(text(),'Label as')]
    Sleep   2s
    ${label_social_check}    Get Element Attribute    xpath=//div[@title='${LABEL}']    aria-checked
    Should Be Equal    ${label_social_check}    true
    Sleep    2s