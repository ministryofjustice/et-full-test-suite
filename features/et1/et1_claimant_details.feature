@javascript
Feature:
  As claimant details page
  I want to ensure that user can submit their claimant details in Welsh or in English

  Background: Claimant's details page
    Given a claimant is on Claimant's details page 

  Scenario: Verify copy texts
    Then Claimant's details page copy texts are displayed in the correct language

  Scenario: Yes to disability
    When I answerd Yes to disability
    Then I should see the option to describe the assistant I need

  Scenario: Outside United Kingdom
    Then I should be able to select Outside United Kingdom as country of residence

  Scenario: Mandatory field validation errors
    When I submit without answering any questions
    Then I should see mandatory errors on the Claimant's details page

  Scenario: Blank email address
    When leaving an email address field blank
    Then I should see an error message for leaving email address field blank
    
  Scenario: Invalid email address
    When entering an invalid email address
    Then I should see an error message for entering invalid email address

  Scenario: Invalid UK postcode error message
    When entering 'UTOI&*"?£$' postcode
    Then I should see an error message for invalid UK postcode please use SW55 9QT

  Scenario: Invalid Date of birth error
    When I submit an invalid date of birth for claimant details page
    Then I should see an invalid error message for date of birth claimant details page

  # Scenario: Save and complete later
  #   When I click on Save and complete later
  #   Then I should be able to return to where I was left off

  # Scenario: Print this page
  #   Then I should be able to print this page  