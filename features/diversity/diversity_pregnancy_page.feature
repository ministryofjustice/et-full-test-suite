@diversity
@javascript
Feature:
  As a claimant on the Disability page
  I would like to select whether I submit my diversity info in Welsh or English
  So that I can use my preferred language

  Background: Disability page
    Given a claimant is on the Pregnancy page

  Scenario: Verify page copy
    Then Pregnancy page copy texts are displayed in the correct language
