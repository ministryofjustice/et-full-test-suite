@diversity
@javascript
Feature:
  As a claimant on the Health page
  I would like to select whether I submit my diversity info in Welsh or English
  So that I can use my preferred language

  Background: Health page
    Given a claimant is on the Health page

  Scenario: Verify page copy
    Then Health page copy texts are displayed in the correct language
