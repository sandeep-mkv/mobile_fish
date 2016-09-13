require "mobile_fish/encoders"

module MobileFish
  class PhoneEncoderService

    def initialize(phone_dictionary)
      @word_matcher = MobileFish::Encoders::WordMatcher.new(phone_dictionary)
    end

    def encode(phone_number)
      @word_matcher.get_matches(phone_number)
    end

  end
end
