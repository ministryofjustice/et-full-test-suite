@javascript
Feature: Diversity monitoring questionnaire
  As a Claimant
  I want, after submitting an online ET1 Claim form, to be able to participate in the online Diversity questionnaire
  So that I can enter my details into a Diversity Survey form

  Scenario: Load Diversity questionnaire from ET1 confirmation page
    Given an employee making a claim
    When the completed form is submitted
    Then I should be able to load diversity questionnaire form page

  Scenario: An empty form is valid as a survey participant
    Given a claimant answered all blank questions on the survey participant form
    When the completed Diversity questionnaire form is submitted
    Then the data is updated in ET Admin system

  Scenario: All questions answered
    Given a claimant answered all questions on the survey participant form
    When the completed Diversity questionnaire form is submitted
    Then I should be on the Thank you page
    And the data is updated in ET Admin system

  Scenario: Religion - Any other religion
    Given a claimant answered 'Any other religion' on the survey participant form
    When the completed Diversity questionnaire form is submitted
    Then I should be on the Thank you page
    And the data is updated in ET Admin system

  Scenario: Prefer not to answer ethnicity
    Given a claimant prefered not to answer ethnicity on the survey participant form
    When the completed Diversity questionnaire form is submitted
    Then I should be on the Thank you page
    And the data is updated in ET Admin system

  Scenario: When I change my answers
    Given a claimant answered all questions on the survey participant form
    When user changed 'claim_type' to 'Redundancy payment'
    And the completed Diversity questionnaire form is submitted
    Then the data is updated in ET Admin system