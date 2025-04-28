require 'rails_helper'

RSpec.describe Menu, type: :model do
  subject { build(:menu) }

  describe "validations" do
    context "when it's valid" do
      it "has a name" do
        expect(subject).to be_valid
      end
    end

    context "when it's invalid" do
      before { subject.name = nil }

      it "doesn't have a name" do
        expect(subject).not_to be_valid
        expect(subject.errors[:name]).to include("can't be blank")
      end
    end
  end

  describe "associations" do
    it "belongs to restaurant" do
      expect(described_class.reflect_on_association(:restaurant).macro).to eq(:belongs_to)
    end

    it "has many menu_listings" do
      expect(described_class.reflect_on_association(:menu_listings).macro).to eq(:has_many)
    end
  end
end
