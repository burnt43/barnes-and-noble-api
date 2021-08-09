require './test/initialize'

module BanApi
  module Testing
    class SearchParserTest < BanApi::Testing::Test
      def test_foo
        search_parser = BanApi::Parsers::Search.new(
          BanApi::Stubs.load_stub(:http_responses, :battle_angel_alita_search)
        )
        search_parser.products
      end
    end
  end
end
