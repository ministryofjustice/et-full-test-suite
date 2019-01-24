@local
@javascript
Feature: Eamil notifications
  As an Employment tribunal
  I want to ensure that users submitting E1 or ET3 forms get an email notification in their preferred language

  Scenario: ET1 - Complete your claim
    Given a claimant continued from Saving your claim page
    Then an email is sent to notify user that a claim has been started

  Scenario: ET1 - Completed claimant's form
    When a claimant completes an ET1 form
    Then an email is sent to notify user that a claim has been successfully submitted

  Scenario: ET3 - Completed respondent's form
    When a respondent completes an ET3 form
    Then an email is sent to notify user that a respondent has been successfully submitted