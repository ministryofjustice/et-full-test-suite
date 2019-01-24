@diversity
@javascript
Feature:
  As a claimant on the Confirmation page
  I would like to select whether I submit my diversity info in Welsh or English
  So that I can use my preferred language

  Background: Confirmation page
    Given a claimant is on the Confirmation page

  Scenario: Verify page copy
    Then Confirmation page copy texts are displayed in the correct language
