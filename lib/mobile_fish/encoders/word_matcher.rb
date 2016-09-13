module MobileFish
  module Encoders
    class WordMatcher

      def initialize phone_dictionary
        @phone_dictionary = phone_dictionary
        @number_word_map = Hash.new {|hash, key| hash[key] = Array.new}
        build_number_word_map
      end

      def get_matches phone_number
        phone_number = phone_number.gsub(/[^0-9]/i, '')
        matched_list = find_word_matches(phone_number, matched_list=[])
        results = process_matched_results(matched_list)
        results.reject! { |words| words =~ /\d-\d/ }
      end

      private

      def build_number_word_map
        if @number_word_map.empty?
          ("0".."9").each {|num| @number_word_map[num] << num}
          @phone_dictionary.each_word do |word|
            word = word.chomp.gsub(/[^a-zA-Z]/i, '').downcase
            digit_encoding = encode_word_as_digits(word)
            unless @number_word_map[digit_encoding].include?(word)
              @number_word_map[digit_encoding] << word
            end
          end
        end
      end

      def encode_word_as_digits(word)
        digit_encodings = MobileFish::Encoders::DIGIT_ENCODINGS
        result = ""
        word.chars.each {|c| result << digit_encodings[c.downcase.to_sym] }
        result
      end

      def find_word_matches(phone_number, results, matched_word_list=[])
        @number_word_map.each_with_index do |(digits, word_list), index|
          remainder = match_and_get_remainder(phone_number, digits)
          if remainder
            matched_word_list_copy = matched_word_list.dup << word_list
            if remainder.empty?
              results << matched_word_list_copy
              results
            else
              find_word_matches(remainder, results, matched_word_list_copy)
            end
          end
        end
        results
      end

      def process_matched_results(results)
        processed_results = []
        results.each do |matched_word_list|
          processed_results << evaluate_word_combinations(matched_word_list)
        end
        processed_results.flatten
      end

      def evaluate_word_combinations(matched_word_list)
        # INPUT = [ ["0"]["how"],["are"], ["you"]]
        # OUTPUT = [["0-HOW-ARE-YOU"]]
        first_word_list, *others = matched_word_list
        if others.empty?
          first_word_list.map {|word| word.upcase}
        else
          first_word_list.map do |word|
            res = evaluate_word_combinations(others)
            res.flatten.map do |other_word|
              "#{word.upcase}-#{other_word.upcase}"
            end
          end
        end
      end

      def match_and_get_remainder(phone_number, digits)
        if phone_number[0..digits.size-1] == digits
          phone_number[digits.size..-1]
        end
      end

    end
  end
end
