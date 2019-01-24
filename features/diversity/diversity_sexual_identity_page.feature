@diversity
@javascript
Feature:
  As a claimant on the Sexual Identity page
  I would like to select whether I submit my diversity info in Welsh or English
  So that I can use my preferred language

  Background: Sexual Identity page
    Given a claimant is on the Sexual Identity page

  Scenario: Verify page copy
    Then Sexual Identity page copy texts are displayed in the correct language
