require 'faker'

FactoryBot.define do
  factory :users, class: OpenStruct do
    name { Faker::Name.name }
    email { Faker::Name.first_name }
    username { Faker::Name.first_name }
    department 'London'
    password 'password'
    users_file 'et_admin_users.csv'
  end
end