FactoryBot.define do
  factory :menu do
    name { Faker::Food.ethnic_category }
    restaurant

    trait :with_menu_items do
      after(:create) do |menu|
        create_list(:menu_listing, 5, menu: menu) do |menu_listing|
          create(:menu_item)
        end
      end
    end
  end
end
