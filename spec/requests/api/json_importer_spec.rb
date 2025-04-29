require 'rails_helper'

RSpec.describe "JsonImpoter API", type: :request do
  describe "POST /api/json-importer" do
    context "when file uploaded is correct" do
      let(:json_file) do
        fixture_path = Rails.root.join("spec", "fixtures", "files", "correct.json")
        Rack::Test::UploadedFile.new(fixture_path, 'application/json')
      end

      it "saves the restaurants with menus and items" do
        expect { post api_json_importer_path, params: { file: json_file } }.to change { Restaurant.count }.by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "when file is not uploaded" do
      it "returns a 400 bad request with an error message" do
        post api_json_importer_path

        expect(response).to have_http_status(:bad_request)
        expect(parsed_body).to include("message" => "no file uploaded")
      end
    end
  end
end
