require 'faker'

FactoryGirl.define do
  factory :holiday do
    start_date { Faker::Date }
    end_date { Faker::Date }
    content "blabla"
    user_id 1
    status "Confirmed"
    sequence(:id) { |n| "#{n}"}
  end
end
