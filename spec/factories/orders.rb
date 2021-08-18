FactoryBot.define do
  factory :order do
    order_number { 1 }
    product_name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 1..500.0) }
    status { 0 }
  end
end
