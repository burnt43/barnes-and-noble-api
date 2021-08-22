module BanApi
  module Objects
    class Abstract
      attr_accessor(
        :available_for_preorder,
        :available_online,
        :available_stores_for_purchase,
        :available_stores_for_pickup,
        :format,
        :price_usd,
        :title,
        :url,
      )
    end
  end
end
