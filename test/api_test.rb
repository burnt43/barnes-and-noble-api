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

        # --------------------------------------------------------------------------------
        products = api.search('battle angel alita')

        assert_equal(20, products.size)

        # Product 0
        test_product = products[0]

        assert_instance_of(BanApi::Objects::Book, test_product)
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

        assert_instance_of(BanApi::Objects::Book, test_product)
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

        assert_instance_of(BanApi::Objects::Book, test_product)
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

        assert_instance_of(BanApi::Objects::Book, test_product)
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

        assert_instance_of(BanApi::Objects::Book, test_product)
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

        assert_instance_of(BanApi::Objects::Book, test_product)
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

        assert_instance_of(BanApi::Objects::Book, test_product)
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

        assert_instance_of(BanApi::Objects::Book, test_product)
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

        assert_instance_of(BanApi::Objects::Book, test_product)
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

        assert_instance_of(BanApi::Objects::Book, test_product)
        assert_equal('Yukito Kishiro', test_product.author_name)
        assert(test_product.available_for_preorder)
        refute(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita 4 (Paperback)', test_product.title)
        assert_equal(12.99, test_product.price_usd)

        # Product 10
        test_product = products[10]

        assert_instance_of(BanApi::Objects::Book, test_product)
        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita: Mars Chronicle, Volume 7', test_product.title)
        assert_equal(10.99, test_product.price_usd)

        # Product 11
        test_product = products[11]

        assert_instance_of(BanApi::Objects::Book, test_product)
        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita: Last Order Omnibus, Volume 1', test_product.title)
        assert_equal(19.99, test_product.price_usd)

        # Product 12
        test_product = products[12]

        assert_instance_of(BanApi::Objects::Book, test_product)
        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita: Last Order Omnibus, Volume 2', test_product.title)
        assert_equal(19.99, test_product.price_usd)

        # Product 13
        test_product = products[13]

        assert_instance_of(BanApi::Objects::Book, test_product)
        assert_equal('Yukito Kishiro', test_product.author_name)
        assert(test_product.available_for_preorder)
        refute(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita: Mars Chronicle, Volume 8', test_product.title)
        assert_equal(10.99, test_product.price_usd)

        # Product 14
        test_product = products[14]

        assert_instance_of(BanApi::Objects::Book, test_product)
        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita: Last Order, Volume 16', test_product.title)
        assert_equal(10.99, test_product.price_usd)

        # Product 15
        test_product = products[15]

        assert_instance_of(BanApi::Objects::Book, test_product)
        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita: Last Order Omnibus, Volume 4', test_product.title)
        assert_equal(19.99, test_product.price_usd)

        # Product 16
        test_product = products[16]

        assert_instance_of(BanApi::Objects::Book, test_product)
        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita: Last Order, Volume 17', test_product.title)
        assert_equal(10.99, test_product.price_usd)

        # Product 17
        test_product = products[17]

        assert_instance_of(BanApi::Objects::Book, test_product)
        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita: Last Order, Volume 19', test_product.title)
        assert_equal(10.99, test_product.price_usd)

        # Product 18
        test_product = products[18]

        assert_instance_of(BanApi::Objects::Book, test_product)
        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita: Last Order, Volume 18', test_product.title)
        assert_equal(10.99, test_product.price_usd)

        # Product 19
        test_product = products[19]

        assert_instance_of(BanApi::Objects::Book, test_product)
        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::PAPERBACK, test_product.format)
        assert_equal('Battle Angel Alita: Last Order Omnibus, Volume 3', test_product.title)
        assert_equal(19.99, test_product.price_usd)

        # --------------------------------------------------------------------------------
        products = api.search('battle angel alita', page: 2)

        assert_equal(20, products.size)

        test_product = products[8]
        assert_instance_of(BanApi::Objects::Book, test_product)
        assert_equal('Yukito Kishiro', test_product.author_name)
        refute(test_product.available_for_preorder)
        assert(test_product.available_online)
        assert_empty(test_product.available_stores_for_purchase)
        assert_empty(test_product.available_stores_for_pickup)
        assert_equal(BanApi::Formats::NOOK_BOOK, test_product.format)
        assert_equal('Battle Angel Alita, Volume 1: Rusty Angel', test_product.title)
        assert_equal(9.99, test_product.price_usd)

        test_product = products[16]
        assert_instance_of(BanApi::Objects::Movie, test_product)

        test_product = products[17]
        assert_instance_of(BanApi::Objects::Music, test_product)

        # --------------------------------------------------------------------------------
        products = api.search('battle angel alita', page: 3)

        assert_equal(6, products.size)

        # --------------------------------------------------------------------------------
        products = api.search('battle angel alita', page: 4)

        assert_equal(0, products.size)
      end
    end
  end
end
