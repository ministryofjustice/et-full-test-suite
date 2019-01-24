@javascript
Feature:
  As an ET Admin User
  I want to log onto the ET Admin section and be able to supply a postal Claimant's workplace Postcode
  So that I can receive the next Claim sequence number

  Background: 
    Given an administrator login
    And load Generate Reference page

  Scenario: Geneate new reference number
    When I enter a postcode 'N1 1PA' 
    Then a random reference number is displayed 'ET1 Postal Fee Group Reference Number:'

  Scenario: Provide postcode with no space
    When I enter a postcode 'N11PA' 
    Then a random reference number is displayed 'ET1 Postal Fee Group Reference Number:'

  Scenario: Provide invalid postcode
    When I enter a postcode 'TW1111' 
    Then an error message is displayed 'Not a valid UK postcode'

  Scenario: Provide invalid characters in postcode
    When I enter a postcode 'TW*&^%$£@n/a' 
    Then an error message is displayed 'Not a valid UK postcode'  