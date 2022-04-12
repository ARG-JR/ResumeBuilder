# Authentication Pages

## Description

The sign in, sign up, and sign out pages.

## Routes

- [`/auth/signup/`](SIGN_UP.md)
  - Displays a user registration form
  - Provides a link to [`/auth/signin/`](SIGN_IN.md) for users who already have an account.
- [`/auth/signin`](SIGN_IN.md)
  - Displays a user login form
  - Provides a link to [`/auth/signup/`](SIGN_UP.md) for users who don't already have an account.
- [`/auth/signout/`](SIGN_OUT.md)
  - Destroys the current user's session and redirects to [`/auth/signin`](SIGN_IN.md).
  - Redirects users not logged in to [`/auth/signin`](SIGN_IN.md)
