module BanApi
  class Api
    def initialize
      # Set base data for all subsequent requests.
      @faraday_connection = Faraday.new(
        url:     base_url,
        params:  {},
        headers: {}
      )
    end

    # Public Stub Methods {{{
    def stub_http_request!(url, params={}, return_value=nil)
      @stubbed_http_requests ||= {}
      @stubbed_http_requests[url] ||= {}
      @stubbed_http_requests[url][params] = return_value
    end

    def clear_stubbed_http_request!
      stubbed_http_requests.clear
    end
    # }}}

    def search_all(term)
    end

    # Public API Methods {{{
    # TODO: Do the format options (bitwise like a C program would do).
    def search(
      term,
      number_of_results_per_page: 20,
      page: 1,
      format: nil
    )
      result = make_request(
        "/s/#{CGI.escape(term)}",
        {
          'Nrpp' => number_of_results_per_page,
          'page' => page
        }
      )
      BanApi::Parsers::Search.new(result).products
    end
    # }}}

    private

    # Private Stub Methods {{{
    def stubbed_http_requests
      @stubbed_http_requests || {}
    end

    def stubbed_value(url, params={})
      stubbed_http_requests.dig(url, params)
    end
    # }}}

    # Private API Methods {{{
    def make_request(url, params={}, type: :get)
      if (my_stubbed_value = stubbed_value(url, params))
        ban_api_info "Loading stub for (url: #{url}, params: #{params.to_s}, type: #{type})"
        my_stubbed_value
      else
        @faraday_connection.send(type, url) do |req|
          params.each do |param_name, param_value|
            req.params[param_name] = param_value
          end
        end
      end
    end

    def base_url
      'https://www.barnesandnoble.com'
    end
    # }}}
  end
end
