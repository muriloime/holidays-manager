require 'faker'

FactoryGirl.define do
  factory :user do
    login { Faker::Internet.email }
    name "tester"
    password "senha123"
  end

  factory :manager do
    manager true
  end

end
