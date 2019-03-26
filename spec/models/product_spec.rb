require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { described_class.new }

  describe 'Associations' do
    it "should belong to a category" do
      t = Product.reflect_on_association(:category)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  describe 'Validations' do
    it "is valid with valid attributes" do
      subject.name = "Name"
      subject.price = 75.00
      subject.quantity = 3
      subject.category = Category.new
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.price = 75.00
      subject.quantity = 3
      subject.category = Category.new
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:name=>["can't be blank"])
    end

    it "is not valid without a price" do
      subject.name = "Name"
      subject.quantity = 3
      subject.category = Category.new
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:price => ["is not a number", "can't be blank"])
            expect(subject.errors.messages).to include(:price_cents => ["is not a number"])
    end

    it "is not valid without a quantity" do
      subject.name = "Name"
      subject.price = 75.00
      subject.category = Category.new
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:quantity=>["can't be blank"])
    end

    it "is not valid without a category" do
      subject.name = "Name"
      subject.price = 75.00
      subject.quantity = 3
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:category=>["can't be blank"])
    end

  end
end
