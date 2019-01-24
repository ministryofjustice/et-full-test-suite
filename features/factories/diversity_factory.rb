FactoryBot.define do
  factory :diversity, class: OpenStruct do
    trait :not_blank do
      claim_type :"claim_type.discrimination"
      sex :"sex.female"
      sexual_identity :"sexual_identity.heterosexual-straight"
      gender_at_birth :"gender_at_birth.yes_answer"
      age_group :"age_group.under-25"
      ethnicity :"ethnicity.mixed-multiple-ethnic-groups"
      ethnicity_subgroup :"ethnicity_subgroup.white-and-black-caribbean"
      disability :"disability.prefer-not-to-say"
      pregnancy :"pregnancy.yes_answer"
      caring_responsibility :"caring_responsibility.yes_answer"
      gender :"gender.male-including-female-to-male-trans-men"
      relationship :"relationship.married"
      religion :"religion.no-religion"
    end

    trait :blank do
      claim_type nil
      sex nil
      sexual_identity nil
      age_group nil
      ethnicity nil
      ethnicity_subgroup nil
      disability nil
      caring_responsibility nil
      gender nil
      gender_at_birth nil
      pregnancy nil
      relationship nil
      religion nil
    end
  end
end