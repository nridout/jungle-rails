require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new }

  describe 'Validations' do
    it "is valid with valid attributes" do
      subject.first_name = "Name"
      subject.last_name = "Last"
      subject.email = "email@email.com"
      subject.password = "password"
      expect(subject).to be_valid
    end

    it "is not valid without a first name" do
      subject.last_name = "Last"
      subject.email = "email@email.com"
      subject.password = "password"
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:first_name=>["can't be blank"])
    end

    it "is not valid without a last name" do
      subject.first_name = "Name"
      subject.email = "email@email.com"
      subject.password = "password"
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:last_name=>["can't be blank"])
    end

    it "is not valid without a email" do
      subject.first_name = "Name"
      subject.last_name = "Last"
      subject.password = "password"
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:email=>["can't be blank", "is invalid"])
    end

    # it "should have a unique email" do
    #   subject.first_name = "Name"
    #   subject.last_name = "Last"
    #   subject.email = "email@email.com"
    #   subject.password = "password"
    #   expect(subject).to validate_uniqueness_of :email
    #   expect(subject.errors.messages).to include(:email=>["can't be blank", "is invalid"])
    # end

    it "is not valid without a password" do
      subject.first_name = "Name"
      subject.last_name = "Last"
      subject.email = "email@email.com"
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:password=>["can't be blank", "is too short (minimum is 6 characters)"])
    end

    it "is not valid if password and password_confirmation fields don't match" do
      subject.first_name = "Name"
      subject.last_name = "Last"
      subject.email = "email@email.com"
      subject.password = "password"
      subject.password_confirmation  = "f"
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:password_confirmation=>["doesn't match Password"])
    end

    it "is not valid if password is less than 6 characters" do
      subject.first_name = "Name"
      subject.last_name = "Last"
      subject.email = "email@email.com"
      subject.password = "pass"
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:password=>["is too short (minimum is 6 characters)"])
    end
  end
end
