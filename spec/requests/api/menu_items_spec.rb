require 'rails_helper'

RSpec.describe "MenuItems API", type: :request do
  let!(:restaurant) { create(:restaurant, :with_menus_and_items) }

  describe "GET /api/restaurants/:restaurant_id/menus/:menu_id/menu_items" do
    context "when the restaurant, the menu and the item exists" do
      it "returns the requested menu with all its items" do
        get api_restaurant_menu_menu_items_path(
          restaurant.id, restaurant.menus.first.id, restaurant.menus.first.menu_items.first.id
        )
        
        expect(response).to have_http_status(:ok)
        expect(parsed_body).to include("id", "name", "menu_items")
      end
    end

    context "when restaurant doesn't exist" do
      it "returns a 400 bad request with an error message" do
        get api_restaurant_menu_menu_items_path(
          -1, restaurant.menus.first.id, restaurant.menus.first.menu_items.first.id
        )
        
        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "restaurant doesn't exist")
      end
    end

    context "when menu doesn't exist" do
      it "returns a 400 bad request with an error message" do
        get api_restaurant_menu_menu_items_path(
          restaurant.id, -1, restaurant.menus.first.menu_items.first.id
        )
        
        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "menu doesn't exist")
      end
    end
  end

  describe "GET api/restaurants/:restaurant_id/menus/:menu_id/menu_items/:id" do
    context "when the restaurant, the menu and the item exists" do
      it "returns the requested item from the restaurant menu" do
        get api_restaurant_menu_menu_item_path(
          restaurant.id, restaurant.menus.first.id, restaurant.menus.first.menu_items.first.id
        ) 

        expect(response).to have_http_status(:ok)
        expect(parsed_body).to include("id", "name", "menu_items")
      end
    end

    context "when restaurant doesn't exist" do
      it "returns a 400 bad request with an error message" do
        get api_restaurant_menu_menu_item_path(
          -1, restaurant.menus.first.id, restaurant.menus.first.menu_items.first.id
        ) 

        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "restaurant doesn't exist")
      end
    end

    context "when menu doesn't exist" do
      it "returns a 400 bad request with an error message" do
        get api_restaurant_menu_menu_item_path(
          restaurant.id, -1,  restaurant.menus.first.menu_items.first.id
        ) 

        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "menu doesn't exist")
      end
    end

    context "when item doesn't exist" do
      it "returns a 400 bad request with an error message" do
        get api_restaurant_menu_menu_item_path(
          restaurant.id, restaurant.menus.first.id, -1 
        ) 

        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "item doesn't exist")
      end
    end
  end
end
