require "mobile_fish/phone_number_encoder"

module MobileFish
  class ApplicationService
    attr_reader :config_options

    def initialize(config_options={})
      @config_options = config_options
      configure
    end

    def start
      return handle_input_from_stdin if @phone_numbers_files.empty?
      handle_input_from_files
    end

    private

    def handle_input_from_stdin
      phone_number = gets.chomp.gsub(/[^0-9]/, '')
      unless phone_number.empty?
        phone_number_encoder = MobileFish::PhoneNumberEncoder.new(
            @dictionary_file
          )
        phone_number_encoder.encode(phone_number).each {|result| puts result}
      end
    end

    def handle_input_from_files
      @phone_numbers_files.each do |file|
        File.open(file).readlines.each do |phone_number|
          phone_number_encoder =  MobileFish::PhoneNumberEncoder.new(
            @dictionary_file
          )
          phone_number_encoder.encode(phone_number).each {|result| puts result}
        end
      end
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
