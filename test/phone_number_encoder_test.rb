require 'test_helper'
require "mobile_fish/phone_number_encoder"

class PhoneNumberEncoderTest < Minitest::Test

  def setup
    @phone_number_matcher = MobileFish::PhoneNumberEncoder.new(DEFAULT_DICTIONARY_FILE)
  end

  def test_that_it_cannot_be_initialized_without_a_dictionary_file
    assert_raises(ArgumentError) { MobileFish::PhoneNumberEncoder.new }
  end

  def test_that_it_gives_the_word_matches_for_given_phone_number
    words = @phone_number_matcher.encode "7829"
    assert_instance_of Array, words
    assert_equal 1, words.size
    assert_equal "RUBY", words.first
  end

  def test_that_it_gives_the_word_matches_for_given_phone_number_where_word_is_duplicated_in_dictionary
    words = @phone_number_matcher.encode "7829"
    assert_instance_of Array, words
    assert_equal 1, words.size
    assert_equal "RUBY", words.first
  end

  def test_that_it_gives_the_word_matches_for_given_phone_number_having_whitespace_and_punctuation
    words = @phone_number_matcher.encode "7829 9,37"
    assert_instance_of Array, words
    assert_equal 1, words.size
    assert_equal "RUBY-YES", words.first
  end

  def test_that_it_gives_correct_word_matches_for_a_given_phone_number_where_result_has_both_word_and_digit
    words = @phone_number_matcher.encode "1469273968"
    assert_instance_of Array, words
    assert_equal "1-HOW-ARE-YOU", words.first
  end

  def test_that_it_does_not_give_a_match_if_two_consecutive_numbers_cant_be_replaced
    words = @phone_number_matcher.encode "22551163"
    assert_instance_of Array, words
    assert_empty words
  end

  def test_that_it_matches_dictionary_word_case_insensitively
    words = @phone_number_matcher.encode "86438"
    assert_instance_of Array, words
    assert_equal 1, words.size
    assert words.include? "TO-GET"
  end

  def test_that_it_gives_all_possible_word_matches_for_a_given_number
      words = @phone_number_matcher.encode "02281228"
      assert_instance_of Array, words
      assert_equal 4, words.size
      assert words.include? "0-BAT-1-BAT"
      assert words.include? "0-BAT-1-CAT"
      assert words.include? "0-CAT-1-CAT"
      assert words.include? "0-CAT-1-BAT"
  end

  def test_that_it_gives_all_possible_word_matches_for_a_given_number_single_letter_word
      words = @phone_number_matcher.encode "446"
      assert_instance_of Array, words
      assert_equal 4, words.size
      assert words.include? "4-I-6"
      assert words.include? "I-I-6"
      assert words.include? "4-GO"
      assert words.include? "I-GO"
  end
end
