require "mobile_fish/phone_encoder_service"
require "mobile_fish/phone_dictionary"

module MobileFish
  class Application
    attr_reader :config_options

    def initialize(config_options={})
      @config_options = config_options
      configure
    end

    def start
      phone_dictionary = PhoneDictionary.instance
      phone_dictionary.set_dictionary @dictionary_file
      @encoder_service = MobileFish::PhoneEncoderService.new(phone_dictionary)
      return handle_input_from_stdin if @phone_numbers_files.empty?
      handle_input_from_files
    end

    private

    def handle_input_from_stdin
      phone_number = gets.chomp.gsub(/[^0-9]/, '')
      unless phone_number.empty?
        @encoder_service.encode(phone_number).each {|result| puts result}
      end
    end

    def handle_input_from_files
      @phone_numbers_files.each do |file_path|
        read_and_process(file_path)
      end
    end

    def read_and_process file_path
      File.open(file_path).readlines.each do |phone_number|
        @encoder_service.encode(phone_number).each {|result| puts result}
      end
    rescue Exception => e
      puts "#{e.message}"
    end

    def configure
      @dictionary_file = MobileFish::DEFAULT_DICTIONARY
      if config_options[:d] and not config_options[:d].empty?
        @dictionary_file = @config_options[:d]
      end
      @phone_numbers_files = []
      if config_options[:f] and not config_options[:f].empty?
        @phone_numbers_files = config_options[:f]
      end
    end

  end
end
