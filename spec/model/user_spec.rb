

require 'rails_helper'

describe "user" do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it "has unique login" do
    expect { FactoryGirl.create(:user) }.to raise_error
  end

end