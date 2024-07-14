Test cases for Eaton by Pavel Glazkov

Test case A (Functional E2E Automation Testing):
1. Login to Gmail (captcha or 2FA do not have to be automated)
2. Compose an email with the subject "Test Email Subject" and the body "Test Email Body"
3. Label email as "Social"
4. Send the email to the same account which was used in the login test step.
5. Wait for the email to arrive in the Inbox
6. Mark the email as starred
7. Open the received email
8. Verify email came under the proper Label i.e. "Social"
9. Verify the subject and body of the received email

Test case B (Functional API Testing):
0. https://jsonplaceholder.typicode.com/
1. Get a random user (userID), and print out its email address to the console.
2. Using this userID, get this user’s associated posts and verify they contain valid Post IDs (an Integer between 1 and 100).
3. Do a post using the same userID with a non-empty title and body, and verify the correct response is returned (since this is a mock API, it might not return Response code 200, so check the documentation).
