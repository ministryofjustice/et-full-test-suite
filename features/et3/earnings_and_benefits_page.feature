@et3 @javascript

Feature: Earnings and benefits page

Background: ET3 earnings and benefits page
  Given I am on the ET3 earnings and benefits page

Scenario: Successfully submits earnings and benefits information
  When I successfully submit information about my earnings and benefits
  Then I should be taken to the response page

Scenario: Proceed without answering earnings and benefits question
  When I click on next without providing the optional earnings and benefits details
  Then I should be taken to the response page