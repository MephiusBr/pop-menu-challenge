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
      end
    end
  end
end
