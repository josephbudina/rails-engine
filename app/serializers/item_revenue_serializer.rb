class ItemRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :unit_price, :merchant_id

  attributes :revenue do |item|
    item.revenue
  end
end