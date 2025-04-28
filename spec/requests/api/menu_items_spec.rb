require 'rails_helper'

RSpec.describe "MenuItems API", type: :request do
  describe "GET /api/menu/:menu_id/menu_items" do
    context "when menu exists" do
      let!(:menu) { create(:menu, :with_menu_items) }

      it "returns the requested menu with all its items" do
        get api_menu_menu_items_path(menu.id)
        
        expect(response).to have_http_status(:ok)
        expect(parsed_body).to include("id", "name", "menu_items")
      end
    end

    context "when menu doesn't exist" do
      it "returns a 400 bad request with an error message" do
        get api_menu_menu_items_path(-1)
        
        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "menu doesn't exist")
      end
    end
  end

  describe "GET /api/menu/:menu_id/menu_items/:id" do
    let!(:menu_item) { create(:menu_item) }

    context "when menu and item exists" do
      it "returns the requested item from menu" do
        get api_menu_menu_item_path(menu_item.menu.id, menu_item.id) 

        expect(response).to have_http_status(:ok)
        expect(parsed_body).to include("id", "name", "price")
      end
    end

    context "when menu doesn't exist" do
      it "returns a 400 bad request with an error message" do
        get api_menu_menu_item_path(-1, menu_item.id) 

        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "menu doesn't exist")
      end
    end

    context "when item doesn't exist" do
      it "returns a 400 bad request with an error message" do
        get api_menu_menu_item_path(menu_item.menu.id, -1) 

        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "item doesn't exist")
      end
    end
  end
end
