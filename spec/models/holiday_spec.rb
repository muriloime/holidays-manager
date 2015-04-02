require 'rails_helper'

describe Holiday do
  describe "has a conflict with another holiday of the same user" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      FactoryGirl.create(:holiday, user_id: @user.id, start_date: Date.today + 1, end_date: Date.today + 3)
    end
    it "(conflict inside)" do
      holiday = FactoryGirl.build(:holiday, user_id: @user.id, start_date: Date.today + 2, end_date: Date.today + 2)
      expect(Holiday.exist_already(holiday, @user, holiday.id)).not_to eq []
    end

    it "(conflict pass)" do
      holiday = FactoryGirl.build(:holiday, user_id: @user.id, start_date: Date.today, end_date: Date.today + 4)
      expect(Holiday.exist_already(holiday, @user, holiday.id)).not_to eq []
    end

    it "(conflict start_date)" do
      holiday = FactoryGirl.build(:holiday, user_id: @user.id, start_date: Date.today + 3, end_date: Date.today + 4)
      expect(Holiday.exist_already(holiday, @user, holiday.id)).not_to eq []
    end

    it "(conflict end_date)" do
      holiday = FactoryGirl.build(:holiday, user_id: @user.id, start_date: Date.today, end_date: Date.today + 1)
      expect(Holiday.exist_already(holiday, @user, holiday.id)).not_to eq []
    end

    it "(false - is not a conflict)" do
      holiday = FactoryGirl.build(:holiday, user_id: @user.id, start_date: Date.today + 4, end_date: Date.today + 5)
      expect(Holiday.exist_already(holiday, @user, holiday.id)).to eq []
    end
  end


end