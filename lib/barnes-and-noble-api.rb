require 'cgi'
require 'stringio'

require 'faraday'
require 'nokogiri'

module BanApi
  class Api
    def initialize
      @faraday_connection = Faraday.new(
        url:     base_url,
        params:  {},
        headers: {}
      )
    end

    def search(term, number_of_results_per_page: 20, page: 1)
      make_request(
        "/s/#{CGI.escape(term)}",
        {
          'Nrpp' => number_of_results_per_page,
          'page' => page
        }
      )
    end

    private

    def make_request(url, params={}, type: :get)
      # TODO: Add stub checking here, so we can stub in the test env.
      @faraday_connection.send(type, url) do |req|
        params.each do |param_name, param_value|
          req.params[param_name] = param_value
        end
      end
    end

    def base_url
      'https://www.barnesandnoble.com'
    end
  end
end
