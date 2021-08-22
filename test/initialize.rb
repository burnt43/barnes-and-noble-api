module Warning
  def warn(msg)
    # NoOp
  end
end

require 'minitest/pride'
require 'minitest/autorun'

require './lib/barnes-and-noble-api'

module BanApi
  module Testing
    class Test < Minitest::Test
    end
  end
end
