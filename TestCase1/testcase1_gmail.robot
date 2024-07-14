*** Settings ***
Documentation    This test case logs in to Gmail, creates an email with the given parameters and verifies that the email was delivered and all parameters are presented
Library           SeleniumLibrary
Suite Setup       Open Browser To Gmail
Suite Teardown    Close Browser
Resource    keywords_gmail.robot
Resource    testdata_gmail.robot

*** Test Cases ***
Gmail Automation Test
    Login To Gmail
    Compose And Send Email With Label
    Wait For Email And Verify