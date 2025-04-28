require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe "validations" do
    context "when it's valid" do
      let(:menu_item) { build(:menu_item) }

      it "has a name" do
        expect(menu_item.name).not_to be_nil
        expect(menu_item).to be_valid
      end

      it "has a price" do
        expect(menu_item.price).not_to be_nil
        expect(menu_item.price).to be > 0
        expect(menu_item).to be_valid
      end
    end

    context "when it's invalid" do
      let(:menu_item) { build(:menu_item) }

      it "doesn't have a name" do
        menu_item.name = nil

        expect(menu_item.name).to be_nil
        expect(menu_item).not_to be_valid
      end

      it "doesn't have a price" do
        menu_item.price = nil

        expect(menu_item.price).to be_nil.or be <= 0
        expect(menu_item).not_to be_valid
      end
    end
  end

  describe "associations" do
    it "belongs to a menu" do
      expect(described_class.reflect_on_association(:menu).macro).to eq(:belongs_to)
    end
  end
end
