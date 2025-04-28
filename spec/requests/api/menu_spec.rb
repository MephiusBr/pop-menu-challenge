require 'rails_helper'

RSpec.describe "Menus API", type: :request do
  describe "GET /api/menu" do
    let!(:menu) { create_list(:menu, 3, :with_menu_items) }

    it "returns all menus with their items" do
      get api_menu_index_path

      expect(response).to have_http_status(:ok)
      expect(parsed_body).to all(include("id", "name", "menu_items"))
    end
  end

  describe "GET /api/menu/:id" do
    context "when the menu exists" do
      let!(:menu) { create(:menu, :with_menu_items) }

      it "returns the requested menu with its items" do
        get api_menu_path(menu.id)

        expect(response).to have_http_status(:ok)
        expect(parsed_body).to include("id", "name", "menu_items")
      end
    end

    context "when the menu doesn't exists" do
      it "returns a 400 bad request with an error message" do
        get api_menu_path(-1)

        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "menu doesn't exist")
      end
    end
  end
end
