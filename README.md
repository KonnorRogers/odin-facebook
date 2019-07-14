# README

## Setting up POSTGRESQL

[I created an issue of how I solved POSTGRES issues in UBUNTU](https://github.com/ParamagicDev/odin-facebook/issues/1)

## OdinProjec Task list


- [x] Use Postgresql for your database from the beginning (not sqlite3), that way your deployment to Heroku will go much more smoothly. See the Heroku Docs for setup info.
2. [x] Users must sign in to see anything except the sign in page.
3. [x] User sign-in should use the Devise gem. Devise gives you all sorts of helpful methods so you no longer have to write your own user passwords, sessions, and #current_user methods. See the Railscast (which uses Rails 3) for a step-by-step introduction. The docs will be fully current.
3. [x] Users can send Friend Requests to other Users.
4. [x] A User must accept the Friend Request to become friends.
5. [x] The Friend Request shows up in the notifications section of a User’s navbar.
6. [ ] Users can create Posts (text only to start).
7. [ ] Users can Like Posts.
8. [ ] Users can Comment on Posts.
9. [ ] Posts should always display with the post content, author, comments and likes.
10. [ ]  Treat the Posts Index page like the real Facebook’s “Timeline” feature – show all the recent posts from the current user and users she is friends with.
11. [ ]  Users can create a Profile with a Photo (just start by using the Gravatar image like you did in the Rails Tutorial).
12. [ ]  The User Show page contains their Profile information, photo, and Posts.
13. [ ]  The Users Index page lists all users and buttons for sending Friend Requests to those who are not already friends or who don’t already have a pending request.
14. [ ]  Sign in should use Omniauth to allow a user to sign in with their real Facebook account. See the RailsCast on FB authentication with Devise for a step-by-step look at how it works.
15. [ ]  Set up a mailer to send a welcome email when a new user signs up. Use the letter_opener gem (see docs here) to test it in development mode.
16. [ ]  Deploy your App to Heroku.
17. [ ]  Set up the SendGrid add-on and start sending real emails. It’s free for low usage tiers.

Extra Credit

1. Make posts also allow images (either just via a URL or, more complicated, by uploading one).
2. Use the Active Storage to allow users to upload a photo to their profile.
3. Make your post able to be either a text OR a photo by using a polymorphic association (so users can still like or comment on it while being none-the-wiser).
4. Style it up nicely! We’ll dive into HTML/CSS in the next course.

