# MobileFish

This is a solution to the 1800-CODING-CHALLENGE.

1-800-CODING-CHALLENGE:
 Many companies like to list their phone numbers using the letters printed on most telephones. This makes the number easier to remember for customers. An example may be 1-800-FLOWERS This coding challenge is to write a program that will show a user possible matches for a list of provided phone numbers.

## Installation
Check out the repo and cd into 'mobile_fish' folder and then run `bundle install`

## Usage

### To run the app:

```ruby
bundle exec exe/mobile_fish phone_numbers.txt
```

 ```ruby
 bundle exec exe/mobile_fish
 ```
in the second case it will prompt for an input, Enter the phone number to get the results.

Examples:

1. When phone_number files is given as arguments
    bundle exec exe/mobile_fish file_1.txt
    USE-RUBY
    CALL-ME
2. When phone_numbers file is not given, it prompts. Enter a phone_number
    bundle exec exe/mobile_fish mobile-fish
    2255-63
    CALL-ME

### To run the tests:  
```ruby
rake test
or
bundle exec rake test
```
