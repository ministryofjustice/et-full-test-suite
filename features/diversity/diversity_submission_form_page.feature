@diversity
@javascript
Feature:
  As a claimant on the Submission Form page
  I would like to select whether I submit my diversity info in Welsh or English
  So that I can use my preferred language

  Scenario: An empty form is valid as a survey participant
    Given a claimant answered all blank questions on the survey participant form
    Then the populated data is displayed on the submission page

  Scenario: All questions answered
    Given a claimant answered all questions on the survey participant form
    Then the populated data is displayed on the submission page

  Scenario: Religion - Any other religion
    Given a claimant answered 'Any other religion' on the survey participant form
    Then the populated data is displayed on the submission page

  Scenario: Prefer not to answer ethnicity
    Given a claimant prefered not to answer ethnicity on the survey participant form
    Then the populated data is displayed on the submission page

  Scenario: When I change my answers
    Given a claimant answered all questions on the survey participant form
    When user changed 'claim_type' to 'Redundancy payment'
    Then the populated data is displayed on the submission page
