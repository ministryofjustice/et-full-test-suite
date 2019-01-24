@diversity
@javascript
Feature:
  As a claimant on the Ethnic Group page
  I would like to select whether I submit my diversity info in Welsh or English
  So that I can use my preferred language

  Background: Ethnic Group page
    Given a claimant is on the Ethnic Group page

  Scenario: Verify page copy
    Then Ethnic Group page copy texts are displayed in the correct language
