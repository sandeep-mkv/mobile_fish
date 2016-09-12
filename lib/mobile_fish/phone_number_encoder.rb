module MobileFish
  class PhoneNumberEncoder

    DIGIT_ENCODINGS = {a: "2", b: "2", c: "2", d: "3", e: "3", f: "3", g: "4",
      h: "4", i: "4", j: "5", k: "5", l: "5", m: "6", n: "6", o: "6", p: "7",
      q: "7", r: "7", s: "7", t: "8", u: "8", v: "8", w: "9", x: "9", y: "9",
      z: "9"}

    def initialize(dictionary_file)
      @dictionary_file = dictionary_file
      configure_dictionary
    end

    def encode(phone_number)
      phone_number = phone_number.gsub(/[^0-9]/i, '')
      matched_list = find_word_matches(phone_number, matched_list=[])
      results = process_matched_results(matched_list)
      results.reject! { |words| words =~ /\d-\d/ }
    end

    private

    def configure_dictionary
      @phone_dictionary = Hash.new {|hash, key| hash[key] = Array.new}
      ("0".."9").each {|num| @phone_dictionary[num] << num}
      File.readlines(@dictionary_file).each do |line|
        word = line.chomp.gsub(/[^a-zA-Z]/i, '')
        digit_encoding = encode_word_as_digits(word)
        unless @phone_dictionary[digit_encoding].include?(word)
          @phone_dictionary[digit_encoding] << word
        end
      end
    end

    def encode_word_as_digits(word)
      digit_encodings = MobileFish::PhoneNumberEncoder::DIGIT_ENCODINGS
      result = ""
      word.chars.each {|c| result << digit_encodings[c.downcase.to_sym] }
      result
    end

    def find_word_matches(phone_number, results, matched_word_list=[])
      @phone_dictionary.each_with_index do |(digits, word_list), index|
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
