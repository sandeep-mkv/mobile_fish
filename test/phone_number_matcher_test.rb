require 'test_helper'
require "mobile_fish/phone_number_matcher"

DEFAULT_DICTIONARY_FILE = "#{Dir.pwd}/test/data/default_dictionary.txt"

class PhoneNumberMatcherTest < Minitest::Test

  def setup
    @phone_number_matcher = MobileFish::PhoneNumberMatcher.new(DEFAULT_DICTIONARY_FILE)
  end

  def test_that_it_cannot_be_initialized_without_a_dictionary_file
    assert_raises(ArgumentError) { MobileFish::PhoneNumberMatcher.new }
  end

  def test_that_it_can_take_an_optional_phone_number_file_on_initialize
    phone_number_matcher1 = MobileFish::PhoneNumberMatcher.new(DEFAULT_DICTIONARY_FILE)
    assert phone_number_matcher1
    phone_number_matcher2 = MobileFish::PhoneNumberMatcher.new(DEFAULT_DICTIONARY_FILE, "file")
    assert phone_number_matcher2
  end

  def test_that_it_gives_the_word_matches_for_given_phone_number
    words = @phone_number_matcher.word_matches "7829"
    assert_instance_of Array, words
    assert_equal "RUBY", words.first
  end

  def test_that_it_gives_the_word_matches_for_given_phone_number_having_whitespace_and_punctuation
    words = @phone_number_matcher.word_matches "4692739 6,8"
    assert_instance_of Array, words
    assert_equal "HOW-ARE-YOU", words.first
  end

  def test_that_it_gives_correct_word_matches_for_a_given_phone_number_where_result_has_both_word_and_digit
    words = @phone_number_matcher.word_matches "1469273968"
    assert_instance_of Array, words
    assert_equal "1-HOW-ARE-YOU", words.first
  end

  def test_that_it_does_not_give_a_match_if_two_consecutive_numbers_cant_be_replaced
    words = @phone_number_matcher.word_matches "22551163"
    assert_instance_of Array, words
    assert_empty words
  end

  def test_that_it_gives_all_possible_word_matches_for_a_given_number_case
    ("0".."9").each do |num|
      words = @phone_number_matcher.word_matches "#{num}225592255"
      assert_instance_of Array, words
      assert_equal 4, words.size
      assert words.include? "#{num}-BALL-9-BALL"
      assert words.include? "#{num}-BALL-9-CALL"
      assert words.include? "#{num}-CALL-9-CALL"
      assert words.include? "#{num}-CALL-9-BALL"
    end
  end
end
