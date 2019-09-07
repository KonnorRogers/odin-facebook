# README

[Link to live site](https://paramagic-app.herokuapp.com/)

## What the live app looks like

[!Gif of website navigation](https://thumbs.gfycat.com/PeriodicShadyKomododragon-size_restricted.gif)


## Getting starting

```bash
bundle install
rails db:create
rails db:migrate
rails db:seed
rails server
```

Navigate to localhost:3000

log in as any user IE:

username: bob@example.com
password: foobar

These users also exist in the real app to play around with

## Setting up POSTGRESQL

[I created an issue of how I solved POSTGRES issues in UBUNTU](https://github.com/ParamagicDev/odin-facebook/issues/1)

## OdinProject Task list

- [x] Use Postgresql for your database from the beginning (not sqlite3), that way your deployment to Heroku will go much more smoothly. See the Heroku Docs for setup info.
- [x] Users must sign in to see anything except the sign in page.
- [x] User sign-in should use the Devise gem. Devise gives you all sorts of helpful methods so you no longer have to write your own user passwords, sessions, and #current_user methods. See the Railscast (which uses Rails 3) for a step-by-step introduction. The docs will be fully current.
- [x] Users can send Friend Requests to other Users.
- [x] A User must accept the Friend Request to become friends.
- [x] The Friend Request shows up in the notifications section of a User’s navbar.
  * In app notifications are handled via AJAX requests to the
    /notifications.json path. Requests made every 10 seconds.
    Requests are disabled while using the dropdown, dropdowns make an automatic AJAX
    post request to /notifications/mark_as_read when clicked
    Dropdowns and AJAX requests made with jQuery. No bootstrap used.
- [x] Users can create Posts (text only to start).
- [x] Users can Like Posts.
  * Liking posts handled via AJAX
- [x] Users can Comment on Posts.
  * I also added the ability to comment on comments. using AJAX with this caused significant complexity.
- [x] Posts should always display with the post content, author, comments and likes.
- [x]  Treat the Posts Index page like the real Facebook’s “Timeline” feature – show all the recent posts from the current user and users she is friends with.
- [x]  Users can create a Profile with a Photo (just start by using the Gravatar image like you did in the Rails Tutorial).
- [x]  The User Show page contains their Profile information, photo, and Posts.
- [x]  The Users Index page lists all users and buttons for sending Friend Requests to those who are not already friends or who don’t already have a pending request.
- [x]  Sign in should use Omniauth to allow a user to sign in with their real Facebook account. See the RailsCast on FB authentication with Devise for a step-by-step look at how it works.
- [x]  Set up a mailer to send a welcome email when a new user signs up. Use the letter_opener gem (see docs here) to test it in development mode.
- [x]  Deploy your App to Heroku.
- [x]  Set up the SendGrid add-on and start sending real emails. It’s free for low usage tiers.

Extra Credit

- [ ] Make posts also allow images (either just via a URL or, more complicated, by uploading one).
  * Not implemented due to free trial of AWS running out, could implement via URL technically
- [ ] Use the Active Storage to allow users to upload a photo to their profile.
  * Not implemented due to free trial of AWS running out
- [ ] Make your post able to be either a text OR a photo by using a polymorphic association (so users can still like or comment on it while being none-the-wiser).
  * Associations in place via commentable & likeable, however not implemented
- [x] Style it up nicely! We’ll dive into HTML/CSS in the next course.
  * Its styled, just not responsive

