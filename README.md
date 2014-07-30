# Habit App

Habit building or breaking through analytics.


## Setup

* Install postgres, on mac you're best bet is: http://postgresapp.com/
* Ensure you have a habit role: ``createuser -s habit``
* rake db:create db:setup
* rails s

## Tests

* brew install chromedriver
* bundle exec cucumber -r features

Enjoy.
