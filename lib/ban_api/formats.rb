module BanApi
  module Formats
    class << self
      def from_raw_string(string)
        possible_const_name = string.to_s.gsub(/\s+/, '_').upcase
        const_get(possible_const_name)
      rescue NameError
        ban_api_warning("Cannot find a format for '#{string}'")
        nil
      end

      def format_to_string(format)
        case format
        when PAPERBACK then 'Paperback'
        when HARDCOVER then 'Hardcover'
        when DVD       then 'DVD'
        when NOOK_BOOK then 'Nook Book'
        when CD        then 'CD'
        end
      end

      def format_to_object_class(format)
        case format
        when PAPERBACK, HARDCOVER, NOOK_BOOK then BanApi::Objects::Book
        when DVD                             then BanApi::Objects::Movie
        when CD                              then BanApi::Objects::Music
        end
      end

      def digital?(format)
        format == NOOK_BOOK
      end

      def physical?(format)
        !digital?(format)
      end
    end

    PAPERBACK = 1
    HARDCOVER = 2
    DVD       = 4
    NOOK_BOOK = 8
    CD        = 16
  end
end
