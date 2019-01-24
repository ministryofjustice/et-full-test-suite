@javascript
Feature:
  As Representative's details page
  I want to ensure that user can submit their Representative's details in Welsh or in English

  Background: Representative's details page
    Given a claimant is on Representative's details page 

  Scenario: Verify copy texts for Representative's details page
    Then I can verify that the copy text on Representative's details page displayed correctly

  Scenario: No to representative
    When I submit a claim without any representative
    Then I should be taken to Respondent's details page

  Scenario: Mandatory field validation
    When I submit without answering any representative questions
    Then I can verify that validation error messages are shown on the Representative's details page

  Scenario: Invalid UK postcode error message
    When entering invalid postcode for Representative's details page
    Then I can verify an invalid UK postcode is being used for Representative's details page

  Scenario: What is a DX number?
    When I click on DX number
    Then I can see the DX information details

  Scenario: Type of representative: Employment advisor, Citizens Advice Bureau
    Then I should be able to select Employment advisor, Citizens Advice Bureau from type of representative

  Scenario: Answer all fields questions
    When I submit all Representative's details page questions
    Then I should be taken to Respondent's details page
