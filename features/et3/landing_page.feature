@et3 @javascript
Feature: ET3 landing page
  As a respondent
  I would like to respond to a claim made against me
  So that I can have my case heard

Background: ET3 landing page
  Given I am on the ET3 landing page

Scenario: Et3 landing page
  Then introduction page copy texts are displayed in the correct language
  When I click on the begin this form button
  Then I should be taken to the respondents details page

Scenario: Other relevant links
  Then I should see other relevant links
  