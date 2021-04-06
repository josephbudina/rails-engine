FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Name.name }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    merchant
  end
end