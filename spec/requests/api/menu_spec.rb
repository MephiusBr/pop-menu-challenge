require 'rails_helper'

RSpec.describe "Menus API", type: :request do
  describe "GET /api/restaurants/:restaurant_id/menus" do
    let!(:restaurant) { create(:restaurant, :with_menus_and_items) }
    
    context "when restaurant exists" do
      it "returns the requested restaurant with its menus and items" do
        get api_restaurant_menus_path(restaurant.id)

        expect(response).to have_http_status(:ok)
        expect(parsed_body).to include("id", "name", "menus")
      end
    end

    context "when restaurant doesn't exist" do
      it "returns a 400 bad request with an error message" do
        get api_restaurant_menus_path(-1)

        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "restaurant doesn't exist")
      end
    end
  end

  describe "GET /api/restaurants/:restaurant_id/menus/:id" do
    let!(:restaurant) { create(:restaurant, :with_menus_and_items) }

    context "when the restaurant and menu exists" do
      it "returns the requested menu with its items" do
        get api_restaurant_menu_path(restaurant.id, restaurant.menus.first.id)

        expect(response).to have_http_status(:ok)
        expect(parsed_body).to include("id", "name", "menu_items")
      end
    end

    context "when the restaurant doesn't exist" do
      it "returns a 400 bad request with an error message" do
        get api_restaurant_menu_path(-1, restaurant.menus.first.id)

        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "restaurant doesn't exist")
      end
    end

    context "when the menu doesn't exist" do
      it "returns a 400 bad request with an error message" do
        get api_restaurant_menu_path(restaurant.id, -1)

        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "menu doesn't exist")
      end
    end
  end
end
