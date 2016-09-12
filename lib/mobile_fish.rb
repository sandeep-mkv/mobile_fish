require "mobile_fish/version"

module MobileFish
  DEFAULT_DICTIONARY = File.join(File.dirname(__FILE__), "../data/default_dictionary.txt")
  require "mobile_fish/application_service"
end
