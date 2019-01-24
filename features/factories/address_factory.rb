require 'faker'

FactoryBot.define do
  factory :address, class: OpenStruct do
    building { Faker::Address.building_number }
    street { Faker::Address.street_name }
    locality 'London'
    county 'Greater London'
    post_code 'SW1H 9AJ'
  end
end