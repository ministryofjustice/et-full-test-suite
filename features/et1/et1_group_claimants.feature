@javascript
Feature:
  As Group claims page
  I want to ensure that user can submit their Group claims in Welsh or in English

  Background: Group claims page
    Given a claimant is on Group claims page 

  Scenario: Verify copy texts on Group claims page
    Then Group claims page copy texts are displayed in the correct language

  Scenario: Single claimant
    When I submit no other people are making claims
    Then I should be on the Respresentative's details page

  Scenario: Verify copy texts for 5 or few claimants
    When there 5 or few claimants
    Then I can very that the copy texts correctly dispayed for group claimants

  Scenario: Two Claimants
    Given two employees making a claim
    Then I should be able to submit two claimant details
    
  Scenario: Verify copy texts for Upload user details in separate spreadsheet
    When there are group claimants
    Then I can very that the copy texts correctly dispayed for Upload user details in separate spreadsheet

  Scenario: No to upload group claimant
    When I submit no to upload group claimant
    Then I should be on the Respresentative's details page

  Scenario: Manually enter claimant details
    When I changed my mind to manually enter claimant details
    Then I should be able to submit two claimant details

  Scenario: Submit group claims via csv file
    When I submit a group claims via csv file
    Then I should be on the Respresentative's details page

  Scenario: Mandatory field validation errors
    When I submit without answering any claimant details
    Then I should see mandatory errors on the Group claims page

  Scenario: Invalid Date of birth error
    When I submit an invalid date of birth
    Then I should see an invalid error message for date of birth
    
  # Scenario: Download spreadsheet template
  #   When I'm on Spreadsheet for group claim
  #   Then I should be able to download spreadsheet template