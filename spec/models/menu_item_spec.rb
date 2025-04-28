require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe "validations" do
    context "when it's valid" do
      let(:menu_item) { build(:menu_item) }

      it "has a unique name" do
        expect(menu_item.name).not_to be_nil
        expect(menu_item).to be_valid
      end

      it "has a price greater than 0" do
        expect(menu_item.price).not_to be_nil
        expect(menu_item.price).to be > 0
        expect(menu_item).to be_valid
      end
    end

    context "when it's invalid" do
      let(:menu_item) { build(:menu_item) }
      let!(:item) { create(:menu_item, name: "test item") }

      it "doesn't have a name" do
        menu_item.name = nil

        expect(menu_item.name).to be_nil
        expect(menu_item).not_to be_valid
        expect(menu_item.errors[:name]).to include("can't be blank")
      end

      it "doesn't have a price" do
        menu_item.price = nil

        expect(menu_item.price).to be_nil
        expect(menu_item).not_to be_valid
        expect(menu_item.errors[:price]).to include("can't be blank")
      end

      it "doesn't have price greater than 0" do
        menu_item.price = 0

        expect(menu_item.price).to be <= 0
        expect(menu_item).not_to be_valid
        expect(menu_item.errors[:price]).to include("must be greater than 0")
      end

      it "doesn't have unique name" do
        menu_item.name = "test item"

        expect(menu_item).not_to be_valid
        expect(menu_item.errors[:name]).to include("has already been taken")
      end
    end
  end

  describe "associations" do
    it "has many menu_listings" do
      expect(described_class.reflect_on_association(:menu_listings).macro).to eq(:has_many)
    end
  end
end
