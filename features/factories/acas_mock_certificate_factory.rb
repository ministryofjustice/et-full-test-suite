FactoryBot.define do
  factory :acas_mock_certificate, class: OpenStruct do
    trait :mock_valid do
      number 'R000082/18/41'
      date_of_receipt Time.parse('01/01/2017 12:00:00')
      date_of_issue Time.parse('01/12/2017 12:00:00')
      method_of_issue 'Email'
      respondent_name 'Respondent’s Name'
      claimant_name 'Claimant’s Name'
    end
    trait :mock_invalid do
      number 'R000201/18/68'
    end
    trait :mock_not_found do
      number 'R000200/18/68'
    end
    trait :mock_server_error do
      number 'R000500/18/68'
    end

  end
end
