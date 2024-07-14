*** Settings ***
Documentation    API Testing in Robot Framework. Get a random user from https://jsonplaceholder.typicode.com/, print its email, verify that its postIDs are integer from 1 to 100, create a post under this user and get the correct response
Library          RequestsLibrary
Library          JSONLibrary

*** Variables ***
${BASE_URL}      https://jsonplaceholder.typicode.com

*** Test Cases ***
Get Random User Email and Verify Posts
    Create Session   jsonplaceholder    ${BASE_URL}
    ${response}      Get Request    jsonplaceholder    /users
    ${users_list}    Set Variable    ${response.json()}  # Get all users
    ${random_index}  Evaluate    random.randint(0, len(${users_list}) - 1)  # Generate a random index
    ${random_user}   Set Variable    ${users_list[${random_index}]}  # Get the random user
    Log              Email Address: ${random_user['email']}

    # Get user's posts
    ${user_id}       Set Variable    ${random_user['id']}
    ${posts_response}  Get Request    jsonplaceholder    /posts?userId=${user_id}
    ${posts}         Set Variable    ${posts_response.json()}    # list of posts

    # Verify Post IDs as integers
    FOR    ${post}    IN    @{posts}
        ${post_id}    Set Variable    ${post['id']}
        Should Be True        1 <= int(${post_id}) <= 100   # Post ID should be between 1 and 100
    END

    # Create a post and verifies the correct response
    ${new_post_data}=    Create Dictionary    userId=${user_id}    title=Test Case Title    body=Test Case Body Content
    ${post_response}=    Post Request    jsonplaceholder    /posts    json=${new_post_data}
    Should Be Equal As Integers    ${post_response.status_code}    201    # the correct response
    Should Contain    ${post_response.headers['Content-Type']}    application/json; charset=utf-8
    Should Be Equal    ${post_response.json()['title']}    Test Case Title    # title verification
    Should Be Equal    ${post_response.json()['body']}    Test Case Body Content    # body verification

