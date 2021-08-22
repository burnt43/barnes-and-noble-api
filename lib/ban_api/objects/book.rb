module BanApi
  module Objects
    class Book < BanApi::Objects::Abstract
      attr_accessor(
        :author
      )

      def to_debug_s
        StringIO.new.tap do |s|
          s.puts '-' * 50
          s.printf("%-30s %s\n", 'title', title)
          s.printf("%-30s %s\n", 'author', author_name)
          s.printf("%-30s %s\n", 'format', format_s)
          s.printf("%-30s %0.2f\n", 'price_usd', price_usd)
          s.printf("%-30s %s\n", 'available_online', available_online)
        end.string
      end

      def author_name
        author&.name
      end

      def format_s
        BanApi::Formats.format_to_string(format)
      end
    end
  end
end
