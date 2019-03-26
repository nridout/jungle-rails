require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) { Category.new(:name => "Furniture") }

  subject {
    described_class.new(name: "Product", price: 75.00,
                      quantity: 4, category: category)
  }

  describe 'Associations' do
    it "should belong to a category" do
      t = Product.reflect_on_association(:category)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  describe 'Validations' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:name=>["can't be blank"])
    end

    it "is not valid without a price" do
      subject.price_cents = nil
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:price => ["is not a number", "can't be blank"])
      expect(subject.errors.messages).to include(:price_cents => ["is not a number"])
    end

    it "is not valid without a quantity" do
      subject.quantity = nil
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:quantity=>["can't be blank"])
    end

    it "is not valid without a category" do
      subject.category = nil
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:category=>["can't be blank"])
    end

  end
end
