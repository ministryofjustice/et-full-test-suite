@javascript
Feature:
  As a claimant
  I would like to select whether I submit my application in Welsh or English
  So that I can use my preferred language

  Background: Saving your claim page
    Given a claimant is on Saving your claim page 

  Scenario: Verify copy texts
    Then Saving your claim copy texts are displayed in the correct language

  # Scenario: Print this page
  #   Then I should be able to print this page  