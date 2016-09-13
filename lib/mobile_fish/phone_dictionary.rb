module MobileFish
  class PhoneDictionary
    include Singleton
    DEFAULT = File.join(File.dirname(__FILE__), "../data/default_dictionary.txt")

    def initialize
    end

    def set_dictionary(file_path="")
      @dictionary_path = (file_path && !file_path.empty?) ? file_path : DEFAULT
    end

    def each_word
      File.readlines(@dictionary_path).each do |word|
        yield(word)
      end
    end
  end
end
