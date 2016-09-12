$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mobile_fish'

require 'minitest/autorun'
require "minitest/reporters"
require 'minitest/stub_any_instance'

Minitest::Reporters.use!

DEFAULT_DICTIONARY_FILE = "#{Dir.pwd}/test/data/test_default_dictionary.txt"
