FactoryBot.define do
  factory :restaurant do
    name { Faker::Restaurant.name }

    trait :with_menus_and_items do
      after(:create) do |restaurant|
        create_list(:menu, 3, restaurant: restaurant) do |menu|
          create_list(:menu_listing, 5, menu: menu) do |menu_listing|
            create(:menu_item)
          end
        end
      end
    end
  end
end
