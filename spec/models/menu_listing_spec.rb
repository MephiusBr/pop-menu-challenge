require 'rails_helper'

RSpec.describe MenuListing, type: :model do
  describe "associations" do
    it "belongs to menu" do
      expect(described_class.reflect_on_association(:menu).macro).to eq(:belongs_to)
    end

    it "belongs to menu_item" do
      expect(described_class.reflect_on_association(:menu_item).macro).to eq(:belongs_to)
    end
  end
end
