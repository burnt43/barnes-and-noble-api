require './test/initialize'

module BanApi
  module Testing
    class ApiTest < BanApi::Testing::Test
      def test_foobar
        # api = BanApi::Api.new
        # api.stub_http_request!(
        #   '/s/battle+angel+alita',
        #   {'Nrpp' => 20, 'page' => 1},
        #   BanApi::Stubs.load_stub(:http_responses, :battle_angel_alita_search)
        # )

        # puts api.search('battle angel alita')
      end
    end
  end
end
