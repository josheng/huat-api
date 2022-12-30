# HUAT API

This Rails API was created to do the following:

* Scrap 4D Results and seed the data
* GET request to return latest result
* GET request to return date of all draws for the past two years
* POST request to check winning number and your prize winnings.
* To be used for a React project

## Set Up

You will require the following to run this locally:

* Ruby 3.1.2
* Rails 7.0.4
* PostgreSQL 14.6
* Selenium chromedriver

Clone this git repo and run the following:

> bundle install
>
> rails db:create db:migrate db:seed
>
> rails s

The above command will do the following:

1. Install all required Gem
2. Create DB, Perform DB Migration and seed data.
3. Start rails server

## API

GET: Retrieve Latest Result

> /api/v1/4d/result
>
> Example Output
>{"id":1,"drawnumber":"4954","drawdate":"2022-12-28","first":"3395","second":"5553","third":"0350","starter":["0817","1698","1829","3198","7721","7934","8129","9205","9277","9774"],"consolation":["1221","2008","3173","3187","4987","5077","6112","6767","9178","9581"],"created_at":"2022-12-29T16:55:02.111Z","updated_at":"2022-12-29T16:55:02.111Z"}

POST: Check Winning Number

> /api/v1/4d/result
>
> Request body example:
>
>{"drawdate":"18/12/2022","number": ["5139","3115","4040","0184","0343"],"bet": [{"b": 1,"s": 2},{"b": 2,"s": 3},{"b": 3,"s": 4},{"b": 4,"s": 5},{"b": 5,"s": 6}]}
>
> Example output:
>
>{"id":5,"drawnumber":"4950","drawdate":"2022-12-18","first":"5139","second":"3115","third":"4040","starter":["0184","0349","0367","3593","6437","6967","7174","7894","8453","9420"],"consolation":["0343","2114","3502","5573","6184","6643","7781","9099","9462","9645"],"created_at":"2022-12-29T16:55:02.732Z","updated_at":"2022-12-29T16:55:02.732Z","winningnumber":["first: 5139, prize: 8000","second: 3115, prize: 8000","third: 4040, prize: 4670","starter: 0184, prize: 1000","consolation: 0343, prize: 300"],"totalwinnings":21970}

GET: Retrieve past 2 year draw dates

>/api/v1/4d/dates
>
>Example output:
>
>["2022-12-28","2022-12-25","2022-12-24","2022-12-21","2022-12-18","2022-12-17","2022-12-14","2022-12-11","2022-12-10","2022-12-07","2022-12-04","2022-12-03","2022-11-30","2022-11-27","2022-11-26","2022-11-23","2022-11-20","2022-11-19","2022-11-16","2022-11-13","2022-11-12","2022-11-09","2022-11-06","2022-11-05","2022-11-02","2022-10-30","2022-10-29","2022-10-26","2022-10-23","2022-10-22","2022-10-19","2022-10-16","2022-10-15","2022-10-12",.....]
