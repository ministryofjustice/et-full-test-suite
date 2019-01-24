@javascript
Feature: Username validation
  As an Admin system
  I want to ensure that there are validation against username when adding or editing username

  Background: 
    When an administrator login
    And add a new user

  Scenario: Username validations
    When I enter "eee" characters in the username field
    Then the following error message is shown "is too short (minimum is 4 characters) and must consist of alphanumeric characters only"

    When I enter "3ee" characters in the username field
    Then the following error message is shown "is too short (minimum is 4 characters), must begin with an uppercase or lowercase letter, and must consist of alphanumeric characters only"

    When I enter "&^%$£@!()**_" characters in the username field
    Then the following error message is shown "must begin with an uppercase or lowercase letter and must consist of alphanumeric characters only"
