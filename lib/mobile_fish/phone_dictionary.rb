require "mobile_fish/util/word_to_digits_encoder"

module MobileFish
  class PhoneDictionary
    DEFAULT = File.join(File.dirname(__FILE__), "../data/default_dictionary.txt")

    def initialize(file_path="")
      @number_to_words_map = nil
      @dictionary_path = (file_path && !file_path.empty?) ? file_path : DEFAULT
    end

    def each_word
      File.readlines(@dictionary_path).each do |word|
        yield(word)
      end
    end

    def build_number_to_words_map
      if not @number_to_words_map or @number_to_words_map.empty?
        build_digits_to_dictionary_words_map
      end
      @number_to_words_map
    end

    private

    def build_digits_to_dictionary_words_map
      @number_to_words_map = Hash.new {|hash, key| hash[key] = Array.new}
      ("0".."9").each {|num| @number_to_words_map[num] << num}
      self.each_word do |word|
        word = word.chomp.gsub(/[^a-zA-Z]/i, '').downcase
        digit_encoding = MobileFish::Util::WordToDigitsEncoder.encode_word_as_digits(word)
        unless @number_to_words_map[digit_encoding].include?(word)
          @number_to_words_map[digit_encoding] << word
        end
      end
    end

  end
end
