# Facebook clone

Final project for [The Odin Project](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project).

Rails app created with `rails new facebook --database=postgresql --css bootstrap`

## Requirements

- [x] Users must be signed in to see anything (but sign-in page)
- [x] Users can send Friend Requests to other Users
    - Reference https://kaylee42.github.io/blog/2016/01/12/reflexive-self-joins-in-rails
- [x] A User must accept the Friend Request to become friends
- [x] The Friend Request shows up in the notifications section of a User’s navbar
- [x] Users can create Posts
- [x] Users can Like Posts
- [x] Users can Comment on Posts
- [x] Posts should always display with the post content, author, comments and likes.
- [x] Treat the Posts Index page like the real Facebook’s “Timeline” feature – show all the recent posts from the current user and users she is friends with
- [ ] Users can create a Profile with their personal information and a photo. You can use Gravatar for this photo.
- [ ] The User Show page contains their Profile information, photo, and Posts.
- [x] The Users Index page lists all users and buttons for sending Friend Requests to those who are not already friends or who don’t already have a pending request.
- [ ] Sign in should use OmniAuth to allow a user to sign in with their real Facebook account. See the RailsCast on FB authentication with Devise for a step-by-step look at how it works.
- [ ] Set up a mailer to send a welcome email when a new user signs up. Use the letter_opener gem (see docs here) to test it in development mode.
- [ ] Deploy your App to a hosting provider.
- [ ] Set up an email provider and start sending real emails.

### Extra credit

- Make posts also allow images (either just via a URL or, more complicated, by uploading one).
- Use Active Storage to allow users to upload a photo to their profile.
- Make your post able to be either a text OR a photo by using a polymorphic association (so users can still like or comment on it while being none-the-wiser).
- Style it up nicely! We’ll dive into HTML/CSS in the next course.

