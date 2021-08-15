module BanApi
  module Parsers
    class Search
      def initialize(response)
        @response = response
        @document = Nokogiri::HTML.parse(response.body)
      end

      def products
        @document.css('div.product-shelf-info').map do |product_info_node|
          title_node   = product_info_node.css('div.product-shelf-title a')[0]
          author_node  = product_info_node.css('div.product-shelf-author a')[0]
          format_node  = product_info_node.css('div.product-shelf-pricing span.format')[0]
          pricing_node = product_info_node.css('div.product-shelf-pricing span')[1]

          online_availability_node = product_info_node.css('div.availability-spacing')[0]
          instore_availability_node = product_info_node.css('div.availability-spacing')[1]

          BanApi::Objects::Book.new.tap do |b|
            b.title     = title_node[:title]
            b.url       = title_node[:href]
            b.format    = BanApi::Formats.from_raw_string(format_node.content.strip)
            b.price_usd = pricing_node.content.strip[1..-1].to_f # Remove leading $-sign

            b.available_online = online_availability_node.css('div.bopis-icon span.icon-check').size == 1

            b.author = BanApi::Objects::Author.new.tap do |a|
              a.name = author_node.content
              a.url  = author_node[:href]
            end
          end
        end
      end
    end
  end
end
