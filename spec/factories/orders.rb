FactoryBot.define do
  factory :order do
    order_number { nil }
    product_name { "PS3" }
    price { 334.98 }
    status { nil }
  end
end
