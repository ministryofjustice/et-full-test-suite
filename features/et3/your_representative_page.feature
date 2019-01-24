@et3 @javascript

Feature: Your representative page

Background: ET3 your representative page
  Given I am on the ET3 your representative page

Scenario: Successfully submit whether I have a representative
  When I successfully submit whether I have a representative
  Then I should be taken to disability page

Scenario: Proceed without answering representative question
  When I click on next without providing whether I have a representative
  Then I should be taken to disability page