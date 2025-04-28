FactoryBot.define do
  factory :menu do
    name { Faker::Food.ethnic_category }

    trait :with_menu_items do
      after(:create) do |menu|
        create_list(:menu_item, 3, menu: menu)
      end
    end
  end
end
