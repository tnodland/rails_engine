FactoryBot.define do
  factory :item do
    merchant
    name { "Good Items" }
    description { "Buy this" }
    unit_price { 5 }
  end
end
