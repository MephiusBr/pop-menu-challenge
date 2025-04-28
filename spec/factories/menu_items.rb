FactoryBot.define do
  factory :menu_item do
    sequence(:name) { |n| "Dish ##{n}" }
    price { Faker::Number.decimal(l_digits: 2) }
    menu
  end
end
