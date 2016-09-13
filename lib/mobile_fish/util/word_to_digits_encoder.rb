require "mobile_fish/util/letter_to_digit_encoding"

module MobileFish
  module Util
    class WordToDigitsEncoder
      def WordToDigitsEncoder.encode_word_as_digits(word)
        digit_encodings = LETTER_TO_DIGIT_ENCODING
        result = ""
        word.chars.each {|c| result << digit_encodings[c.downcase.to_sym] }
        result
      end
    end
  end
end
