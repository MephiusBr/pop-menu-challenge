require 'rails_helper'

RSpec.describe "Restaurants API", type: :request do
  let!(:restaurant) { create(:restaurant, :with_menus_and_items) }

  describe "GET /api/restaurants" do
    it "returns all restaurants with its menus and items" do
      get api_restaurants_path

      expect(response).to have_http_status(:ok)
      expect(parsed_body).to all(include("id", "name", "menus"))
    end
  end

  describe "GET /api/restaurants/:id" do
    context "when the restaurant exists" do
      it "returns the requested restaurant with its menus and items" do
        get api_restaurant_path(restaurant.id)

        expect(response).to have_http_status(:ok)
        expect(parsed_body).to include("id", "name", "menus")
      end
    end

    context "when the restaurant doesn't exist" do
      it "returns a 400 bad request with an error message" do
        get api_restaurant_path(-1)

        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "restaurant doesn't exist")
      end
    end
  end
end
