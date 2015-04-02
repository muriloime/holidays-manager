require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it "is invalid without a login" do
    user = FactoryGirl.build(:user, login: nil)
    user.valid?
    expect(user.errors[:login]).to include("can't be blank")
  end

  describe "About Passwords" do
    it "is invalid without a password" do
      user = FactoryGirl.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid with a password < 6 caracters" do
      user = FactoryGirl.build(:user, password: "12345")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it "is invalid with a password > 10 caracters" do
      user = FactoryGirl.build(:user, password: "12345678901")
      user.valid?
      expect(user.errors[:password]).to include("is too long (maximum is 10 characters)")
    end
  end

  it "is invalid without a name" do
    user = FactoryGirl.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate login address" do
    FactoryGirl.create(:user, login: 'example@example.com')
    user = FactoryGirl.build(:user, login: 'example@example.com')
    user.valid?
    expect(user.errors[:login]).to include('has already been taken')
  end
end

