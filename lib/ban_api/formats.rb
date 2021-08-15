module BanApi
  module Formats
    class << self
      def from_raw_string(string)
        possible_const_name = string.to_s.upcase
        BanApi::Formats.const_get(possible_const_name)
      rescue NameError
        ban_api_format("Cannot find a format for '#{string}'")
        nil
      end

      def format_to_string(format)
        case format
        when BanApi::Formats::PAPERBACK then 'Paperback'
        when BanApi::Formats::HARDCOVER then 'Hardcover'
        when BanApi::Formats::DVD then 'DVD'
        end
      end
    end

    PAPERBACK = 1
    HARDCOVER = 2
    DVD       = 4
  end
end
