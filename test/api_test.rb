require './test/initialize'

module BanApi
  module Testing
    class ApiTest < BanApi::Testing::Test
      def test_foobar
        BanApi::Api.search('battle angel alita')
      end
    end
  end
end
