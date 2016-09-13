# MobileFish

This gem is a solution to the 1800-CODING-CHALLENGE.

1-800-CODING-CHALLENGE:
 Many companies like to list their phone numbers using the letters printed on most telephones. This makes the number easier to remember for customers. An example may be 1-800-FLOWERS This coding challenge is to write a program that will show a user possible matches for a list of provided phone numbers.

## Installation
Check out the repo and cd into 'mobile_fish' folder and To install this gem onto your local machine:
run `bundle exec rake install`
or
To use it in a Gemfile, add
```ruby
gem 'mobile_fish'
```
## Usage

Once the gem is installed locally, you can use the executable `mobile-fish`
Examples:
  1) When phone_number files is given as arguments
    mobile-fish file_1.txt file_2.txt
    USE-RUBY
    CALL-ME
  2) When phone_numbers file is not given, it propts to enter the phone_number
    mobile-fish
    2255-63
    CALL-ME


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
