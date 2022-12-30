# HUAT API

This Rails API was created to do the following:

* Scrap 4D Results and seed the data
* GET request to return latest result
* GET request to return date of all draws for the past two years
* POST request to check winning number and your prize winnings.

## Set Up

You will require the following to run this locally:

* Ruby 3.1.2
* Rails 7.0.4
* PostgreSQL 14.6
* Selenium chromedriver

Clone this git repo and run the following:

> bundle install
> rails db:create db:migrate db:seed
> rails s

The above command will do the following:

1. Install all required Gem
2. Create DB, Perform DB Migration and seed data.
3. Start rails server

## API
