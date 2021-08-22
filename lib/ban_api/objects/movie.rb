module BanApi
  module Objects
    class Movie < BanApi::Objects::Abstract
      attr_accessor(
        :director
      )
    end
  end
end
