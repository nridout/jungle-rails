require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(first_name: "Anything", last_name: "Lorem",
                      email: "email@email.com", password: "password", password_confirmation: "password")
  }

  describe 'Validations' do

    # Valid with all required fields filled out

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    # Not valid without first_name, last_name, email, password & password_confirmation

    it "is not valid without a first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:first_name=>["can't be blank"])
    end

    it "is not valid without a last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:last_name=>["can't be blank"])
    end

    it "is not valid without a email" do
      subject.email = nil
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:email=>["can't be blank", "is invalid"])
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:password=>["can't be blank"])
    end

    it "is not valid without a password confirmation" do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:password_confirmation=>["can't be blank"])
    end

    # Password & password_confirmation must match

    it "is not valid if password and password_confirmation fields don't match" do
      subject.password_confirmation  = "f"
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:password_confirmation=>["doesn't match Password"])
    end

    # Emails must be unique & case insensitive

    it "should have a unique email" do
      expect(subject).to validate_uniqueness_of(:email).case_insensitive
    end

    # Email login can contain spaces

    it "is valid with spaces around email" do
      subject.email = "   email@email.com"
      expect(subject).to be_valid
    end


    # Password must have a minimum length

    it "is not valid if password is less than 6 characters" do
      subject.password = "pass"
      expect(subject).to_not be_valid
      expect(subject.errors.messages).to include(:password=>["is too short (minimum is 6 characters)"])
    end
  end

end
