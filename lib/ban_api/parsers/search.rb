module BanApi
  module Parsers
    class Search
      def initialize(response, requested_store: nil)
        @response        = response
        @document        = Nokogiri::HTML.parse(response.body)
        @requested_store = requested_store
      end

      def products
        @document.css('div.product-shelf-info').map do |product_info_node|
          # Find nodes that contain the information we want.
          title_node         = product_info_node.css('div.product-shelf-title a')[0]
          author_node        = product_info_node.css('div.product-shelf-author a')[0]
          format_node        = product_info_node.css('div.product-shelf-pricing span.format')[0]
          pricing_node       = product_info_node.css('div.product-shelf-pricing span')[1]
          availability_nodes = product_info_node.css('div.availability-spacing')

          # Create a lambda for seeing if a particular attribute is available.
          has_availability_node_enabled = ->(text) {
            availability_nodes.any? do |n|
              n.css('p.bopis-badge-message')&.[](0)&.content&.strip == text && # Must contain given text
              n.css('div.bopis-icon span.icon-check').size == 1 # Must have a checkmark icon
            end
          }

          # Parse out data for each attribute of the Book class.
          author =
            BanApi::Objects::Author.new.tap do |a|
              a.name = author_node.content.strip
              a.url  = author_node[:href]
            end

          available_for_preorder = has_availability_node_enabled.call('Pre-order Now')
          available_online = has_availability_node_enabled.call('Available Online')

          available_stores_for_purchase = []
          if @requested_store && has_availability_node_enabled.call('In Stock at My Store')
            available_stores_for_purchase.push(@requested_store)
          end

          available_stores_for_pickup = []
          if @requested_store && has_availability_node_enabled.call('Store Pickup Available')
            available_stores_for_pickup.push(@requested_store)
          end

          format = BanApi::Formats.from_raw_string(format_node.content.strip)

          price_usd = pricing_node.content.strip[1..-1].to_f # Remove leading $-sign

          title = title_node[:title]

          url = title_node[:href]

          # Create the Book.
          BanApi::Objects::Book.new.tap do |b|
            b.author                        = author
            b.available_for_preorder        = available_for_preorder
            b.available_online              = available_online
            b.available_stores_for_purchase = available_stores_for_purchase
            b.available_stores_for_pickup   = available_stores_for_pickup
            b.format                        = format
            b.price_usd                     = price_usd
            b.title                         = title
            b.url                           = url
          end
        end
      end
    end
  end
end
