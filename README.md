# notes-with-push-notification-api

* Ruby version 2.7.2

* Rails version 6.0.3.7

* Database postgresql

* Uses `gem 'jwt'` for authorization token

* Uses `gem 'rpush'` for push notification

* Clone  `$ git clone git@github.com:VarujanTolbakyan/Blog_with_rails_api.git`

* `$ bundle`

* `$ rails db:create`

* `$ rails server`

* For registration use command `$ curl -X POST -H 'Content-Type: application/json' -d '{"user": {"name": "name", "email": "exampleuser@gmail.com", "password": "exampleuser"}}' http://localhost:3000/users`


* output: `{ "auth_token" : "some token" } (token // 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1LCJleHAiOjE2MjE4NTM2MjJ9.3e6NKMV63XOqldb2pDg_4o6WK9UjiIIv8bGogya8MSU')`


* For login use command `$ curl -X POST -H 'Content-Type: application/json' -d '{"user": {"email": "exampleuser@gmail.com", "password": "exampleuser"}}' http://localhost:3000/users/login`


* ․․․․․ etc․


* Android - Create an app using the Google Authentication key `$ bundle exec rails runner lib/tasks/run_once/android_create_app_using_gcm_auth_key.rb`


* How to push a notification `bundle exec rails runner lib/tasks/run_once/test_users_push_notification.rb`


