@et3 @javascript

Feature: Disability page

Background: ET3 disability page
  Given I am on the ET3 disability page

Scenario: Successfully submits whether I have a disability
  When I successfully submit whether I have a disability
  Then I should be taken to the employers contract claim page

Scenario: Proceed without answering the disability question
  When I click on next without answering the disability question
  Then I should be taken to the employers contract claim page

Scenario: Displays required information error message
  When I click on yes without providing the required disability question
  Then I should see the error message saying the disability details cant be blank
