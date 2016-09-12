require 'test_helper'
require "mobile_fish/phone_number_encoder"
require "mobile_fish/application_service"

SAMPLE_DICTIONARY_FILE = "#{Dir.pwd}/test/data/sample_dictionary.txt"
PHONE_NUMBERS_FILE = "#{Dir.pwd}/test/data/phone_numbers.txt"

class ApplicationServiceTest < Minitest::Test

  def test_that_it_has_an_option_to_configure_it_to_use_dictionary_provided_by_user
    app_service = MobileFish::ApplicationService.new({d:"/path/to/dictionary.txt"})
    assert_equal "/path/to/dictionary.txt", app_service.config_options[:d]
  end

  def test_that_it_has_an_option_to_configure_it_to_read_phone_numbers_from_files
    app_service = MobileFish::ApplicationService.new({f:["/path/to/phone_numbers.txt"]})
    assert_instance_of Array, app_service.config_options[:f]
    assert_equal "/path/to/phone_numbers.txt", app_service.config_options[:f].first
  end

  def test_that_it_gives_correct_word_matches_to_phone_numbers_read_from_files
    config_options = {f: [PHONE_NUMBERS_FILE]}
    assert_output("RUBY\n") {
      MobileFish::ApplicationService.new(config_options).start
    }
  end

  def test_that_it_gives_correct_word_matches_to_phone_number_read_from_stdin
    MobileFish::ApplicationService.stub_any_instance(:gets, "7829") do
      assert_output("RUBY\n") {
        MobileFish::ApplicationService.new().start
      }
    end
  end

  def test_that_it_does_not_return_any_result_if_number_from_stdin_is_invalid
    MobileFish::ApplicationService.stub_any_instance(:gets, "invalid_number") do
      assert_output("") {
        MobileFish::ApplicationService.new().start
      }
    end
  end

  def test_that_it_does_not_return_any_result_if_number_from_stdin_has_no_matches
    MobileFish::ApplicationService.stub_any_instance(:gets, "9538719531") do
      assert_output("") {
        MobileFish::ApplicationService.new().start
      }
    end
  end

  def test_that_it_gives_correct_results_when_configured_to_use_a_dictionary_provided_by_user
    config_options = {d: SAMPLE_DICTIONARY_FILE}
    MobileFish::ApplicationService.stub_any_instance(:gets, "767886732724") do
      assert_output("SORT-TO-SEARCH\n") {
        MobileFish::ApplicationService.new(config_options).start
      }
    end
  end
end
