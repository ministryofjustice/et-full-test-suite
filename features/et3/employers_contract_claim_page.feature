@et3 @javascript 

Feature: Employers contract claim page

Background: ET3 employers contract claim page
  Given I am on the ET3 employers contract claim page

Scenario: Successfully submits employers contract claim information
  When I successfully submit whether I wish to make an employers contract claim
  Then I should be taken to the additional information page

Scenario: Proceed without answering employers contract claim question
  When I click on next without providing a response to employers contract claim question
  Then I should be taken to the additional information page
