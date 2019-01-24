FactoryBot.define do
  factory :acas_certificate, class: OpenStruct do
    trait :valid do
      number 'R000079/18/68'
      date_of_receipt Time.parse('24/05/2018 09:41:45')
      date_of_issue Time.parse('24/05/2018 10:15:01')
      method_of_issue 'Email'
      respondent_name 'Individual Unrepresented ECSO Closure'
      claimant_name 'Claimant Certificate-Lookup1'
    end
    trait :invalid do
      number 'R000201/18/68'
    end
    trait :not_found do
      number 'R000200/18/68'
    end
    trait :server_error do
      number 'R000500/18/68'
    end
  end
end