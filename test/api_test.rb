require './test/initialize'

module BanApi
  module Testing
    class ApiTest < BanApi::Testing::Test
      def test_search
        api = BanApi::Api.new
        api.stub_http_request!(
          '/s/battle+angel+alita',
          {'Nrpp' => 20, 'page' => 1},
          BanApi::Stubs.load_stub(:http_responses, :battle_angel_alita_search_page_01)
        )

        products = api.search('battle angel alita')

        assert_equal(20, products.size)
        # Product 0
        assert_equal('Battle Angel Alita Deluxe Complete Series Box Set', products[0].title)
        assert_equal('Yukito Kishiro', products[0].author_name)
        assert_equal(BanApi::Formats::HARDCOVER, products[0].format)
        assert(products[0].available_online)
        assert_equal(179.94, products[0].price_usd)
      end
    end
  end
end
