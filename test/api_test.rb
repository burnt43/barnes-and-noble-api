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

        api.stub_http_request!(
          '/s/battle+angel+alita',
          {'Nrpp' => 20, 'page' => 2},
          BanApi::Stubs.load_stub(:http_responses, :battle_angel_alita_search_page_02)
        )

        api.stub_http_request!(
          '/s/battle+angel+alita',
          {'Nrpp' => 20, 'page' => 3},
          BanApi::Stubs.load_stub(:http_responses, :battle_angel_alita_search_page_03)
        )

        api.stub_http_request!(
          '/s/battle+angel+alita',
          {'Nrpp' => 20, 'page' => 4},
          BanApi::Stubs.load_stub(:http_responses, :battle_angel_alita_search_page_04)
        )

        products = api.search('battle angel alita')

        assert_equal(20, products.size)

        # Product 0
        test_product = products[0]

        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::HARDCOVER, test_product.format)
        assert_equal('Battle Angel Alita Deluxe Complete Series Box Set', test_product.title)
        assert_equal(179.94, test_product.price_usd)

        # Product 1
        test_product = products[1]

        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::HARDCOVER, test_product.format)
        assert_equal('Battle Angel Alita Deluxe 1 (Contains Vol. 1-2)', test_product.title)
        assert_equal(29.99, test_product.price_usd)

        # Product 2
        test_product = products[2]

        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::HARDCOVER, test_product.format)
        assert_equal('Battle Angel Alita Deluxe 2 (Contains Vol. 3-4)', test_product.title)
        assert_equal(29.99, test_product.price_usd)

        # Product 3
        test_product = products[3]

        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::HARDCOVER, test_product.format)
        assert_equal('Battle Angel Alita Deluxe 3 (Contains Vol. 5-6)', test_product.title)
        assert_equal(29.99, test_product.price_usd)

        # Product 4
        test_product = products[4]

        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::HARDCOVER, test_product.format)
        assert_equal('Battle Angel Alita Deluxe 4 (Contains Vol. 7-8)', test_product.title)
        assert_equal(29.99, test_product.price_usd)

        # Product 5
        test_product = products[5]

        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::HARDCOVER, test_product.format)
        assert_equal('Battle Angel Alita Deluxe 5 (Contains Vol. 9 & Ashen Victor)', test_product.title)
        assert_equal(29.99, test_product.price_usd)

        # Product 6
        test_product = products[6]

        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita 1 (Paperback)', test_product.title)
        assert_equal(12.99, test_product.price_usd)

        # Product 7
        test_product = products[7]

        assert_equal('Yukito Kishiro', test_product.author_name)
        assert(test_product.available_for_preorder)
        refute(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita 2 (Paperback)', test_product.title)
        assert_equal(12.99, test_product.price_usd)

        # Product 8
        test_product = products[8]

        assert_equal('Yukito Kishiro', test_product.author_name)
        assert(test_product.available_for_preorder)
        refute(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita 3 (Paperback)', test_product.title)
        assert_equal(12.99, test_product.price_usd)

        # Product 9
        test_product = products[9]

        assert_equal('Yukito Kishiro', test_product.author_name)
        assert(test_product.available_for_preorder)
        refute(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita 4 (Paperback)', test_product.title)
        assert_equal(12.99, test_product.price_usd)
      end
    end
  end
end
