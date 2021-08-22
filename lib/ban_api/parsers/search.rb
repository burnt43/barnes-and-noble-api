module BanApi
  module Parsers
    class Search
      def initialize(response, requested_store: nil)
        @response        = response
        @document        = Nokogiri::HTML.parse(response.body)
        @requested_store = requested_store
      end

      def products
        # Check to see if there are 0 results before trying to parse results,
        # because we'll be parsing B&N's recommendations and not our results
        # in this case.
        possible_zero_results_string = @document.css('div.resultsListContainer div p')&.[](0)&.content&.strip
        if possible_zero_results_string == "Sorry, we couldn't find what you're " \
                                           "looking for. Please try another search " \
                                           "or browse our recommendations below."
        then
          return [] 
        end

        @document.css('div.product-shelf-info').map do |product_info_node|
          format_node = product_info_node.css('div.product-shelf-pricing span.format')[0]
          format = BanApi::Formats.from_raw_string(format_node.content.strip)

          object_class = BanApi::Formats.format_to_object_class(format)
          case object_class.name
          when 'BanApi::Objects::Book'
            # Find nodes that contain the information we want.
            title_node         = product_info_node.css('div.product-shelf-title a')[0]
            author_node        = product_info_node.css('div.product-shelf-author a')[0]
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
            title = title_node[:title]
            url = title_node[:href]
            price_usd = pricing_node.content.strip[1..-1].to_f # Remove leading $-sign

            author =
              BanApi::Objects::Author.new.tap do |a|
                a.name = author_node.content.strip
                a.url  = author_node[:href]
              end

            available_for_preorder = has_availability_node_enabled.call('Pre-order Now')
            available_online = BanApi::Formats.digital?(format) || has_availability_node_enabled.call('Available Online')

            available_stores_for_purchase = []
            if @requested_store && has_availability_node_enabled.call('In Stock at My Store')
              available_stores_for_purchase.push(@requested_store)
            end

            available_stores_for_pickup = []
            if @requested_store && has_availability_node_enabled.call('Store Pickup Available')
              available_stores_for_pickup.push(@requested_store)
            end

            # Create the Book.
            object_class.new.tap do |b|
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
          when 'BanApi::Objects::Movie'
            object_class.new.tap do |m|
              # FIXME: Set movie attributes. I don't actually care about movies
              #   for my use case, but I'll leave this here if I care in the
              #   future.
            end
          when 'BanApi::Objects::Music'
            object_class.new.tap do |m|
              # FIXME: Set music attributes. I don't actually care about music
              #   for my use case, but I'll leave this here if I care in the
              #   future.
            end
          else
            ban_api_warning(
              "Cannot create an object from search results. " \
              "Don't know how to handle format #{format}"
            )
          end
        end
      end
    end
  end
end
