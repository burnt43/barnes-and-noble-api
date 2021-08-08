require './test/initialize'

module BanApi
  module Testing
    class ApiTest < BanApi::Testing::Test
      def test_foobar
        api = BanApi::Api.new
        puts api.search('battle angel alita')
      end
    end
  end
end
