module BanApi
  module Objects
    class Author < BanApi::Objects::Abstract
      attr_accessor *(%i[
        name
        url
      ])
    end
  end
end
