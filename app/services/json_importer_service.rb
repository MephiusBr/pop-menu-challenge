class JsonImporterService
  def initialize(json)
    @json_data = json.read
  end

  def call
    parsed_json = JSON.parse(@json_data)
    restaurants = parsed_json["restaurants"]

    unless parsed_json["restaurants"].present? then
      raise "Invalid JSON format: 'restaurants' key missing"
    end

    restaurants.each do |restaurant|
      verify_restaurant_keys(restaurant)

      menus = restaurant["menus"]
      menus.each do |menu|
        verify_menu_keys(menu)

        menu_items = menu["menu_items"]
        menu_items.each { |menu_item| verify_menu_item_keys(menu_item) }
      end
    end

    create_resource!(restaurants)
  end

  private

  def create_resource!(restaurants)
    ActiveRecord::Base.transaction do
      restaurants = restaurants.each do |restaurant|
        resource  = Restaurant.create!(name: restaurant["name"])

        restaurant["menus"].each do |menu|
          menu_resource = Menu.create!(name: menu["name"], restaurant_id:
          resource.id)

          menu["menu_items"].each do |menu_item|
            menu_resource.menu_items << MenuItem.create!(menu_item)
          end

          resource.menus << menu_resource
          resource.save!
        end
      end
    end
  end

  def verify_restaurant_keys(restaurant)
    unless restaurant.key?("name") && restaurant.key?("menus") then
      raise "Invalid JSON format: Restaurant must contain keys 'name' and 'menus'"
    end
  end

  def verify_menu_keys(menu)
    unless menu.key?("name") && menu.key?("menu_items") then
      raise "Invalid JSON format: Menu must contain keys 'name' and 'menu_items'"
    end
  end

  def verify_menu_item_keys(menu_item)
    unless menu_item.key?("name") && menu_item.key?("price") then
      raise "Invalid JSON format: MenuItem must contain keys 'name' and 'price'"
    end
  end
end
