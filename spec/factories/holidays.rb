require 'faker'

FactoryGirl.define do
  factory :holiday do
    start_date { Date.today }
    end_date { Date.today }
    content "tester"
    user_id 1
    status "Pending"
    sequence(:id) { |n| "#{n}"}

    factory :admin_holiday do
      status "Confirmed"
    end
  end
end
