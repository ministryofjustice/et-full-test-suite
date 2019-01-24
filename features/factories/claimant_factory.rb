require 'faker'

FactoryBot.define do
  factory :claimant, class: OpenStruct do
      gender :"simple_form.options.claimant.gender.male"
      country :"simple_form.options.claimant.address_country.united_kingdom"
      has_special_needs :"simple_form.yes"
      special_needs 'My special needs are as follows'
      telephone_number '01234 567890'
      alternative_telephone_number '01234 098765'
      email_address "sivvoy.taing@hmcts.net"
      correspondence :"simple_form.options.claimant.contact_preference.email"
      memorable_word 'password'
    
    trait :person_data do
      title :"simple_form.options.claimant.title.miss"
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      date_of_birth '21/11/1982'
      building { Faker::Address.building_number }
      street { Faker::Address.street_name }
      locality 'London'
      county 'Manchester'
      post_code 'SW1H 9AJ'
    end

    trait :group_claims do
      group_claims_csv 'simple_user_with_csv_group_claims.csv'
    end
  end
end
