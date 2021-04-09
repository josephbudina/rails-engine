class MostItemsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attributes :count do |merchant|
    merchant.merchant_item_count
  end
end