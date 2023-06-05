# Scrimmage Rewards Integration for Swift/iOS

This README provides step-by-step instructions on how to integrate
the Scrimmage Rewards program into your Swift/iOS application.

## Prerequisites

Before integrating the Scrimmage Rewards program into your Swift/iOS application,
ensure that you have the following prerequisites in place:

- Xcode (or any other compatible development environment) installed on your machine.
- Access to the Scrimmage Rewards program and an active account.
- A backend server that can return a valid token for the Scrimmage Rewards program.

## Integration Steps

Follow the steps below to integrate the Scrimmage Rewards
program into your Swift/iOS application:

1. **Install the WebKit framework**

   To enable the Scrimmage Rewards program to display its content within a WebView,
   you need to import the WebKit framework into your project. This framework provides
   the necessary components for embedding web content within your iOS application.

2. **Add token retrieval logic for user authentication**

   The Scrimmage Rewards program requires a valid token to authenticate the user
   and display the program's content. Implement the logic to retrieve the token
   from your backend server. Once you have retrieved the token, you can pass
   it to the Scrimmage Rewards program to authenticate the user and display
   the program's content.

