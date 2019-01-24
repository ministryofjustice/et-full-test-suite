@e2e
@javascript
Feature:
  As an ATOS admin
  I want to be able to download completed Employment Tribunal forms
  So I can triage an employees claim against their employer
  
  Scenario: PDF format
    Given an employee making a claim
    When the completed form is submitted
    Then I can download the form and validate in PDF format

  Scenario: TXT format
    Given an employee making a claim
    When the completed form is submitted
    Then I can download the form and validate in TXT format

  Scenario: RTF format
    Given an employee making a claim by uploading a Rich Text Format document
    When the completed form is submitted
    Then I can download the form and validate in Rich Text format

  Scenario: No representative
    Given an employee making a claim without a respresentative
    When the completed form is submitted
    Then I can download the form and validate in PDF format

  Scenario: 2 people making a claim
    Given 2 employees making a claim
    When the completed form is submitted
    Then I can download the form and validate in PDF format

  Scenario: Validate TXT file when uploading CSV data
    Given 7 employees making a claim by uploading CSV file
    When the completed form is submitted
    Then I can download the uploaded CSV data and validate in TXT format

  Scenario: Validate CSV file when uploading CSV data
    Given 7 employees making a claim by uploading CSV file
    When the completed form is submitted
    Then I can download the uploaded CSV data and validate in CSV format

  Scenario: Making claim against 3 employers
    Given an employee making a claim against 3 employers
    When the completed form is submitted
    Then I can download the form and validate the TXT file contained 3 employers details

  Scenario: Ignore special characters in first and last name when generating filenames
    When a claimant submitted an ET1 with special characters in the first and last name 
    Then I can download the form and validate in PDF format

  Scenario: No employment details
    Given a claimant submitted an ET1 with no employment details
    When the completed form is submitted
    Then  I can download the form and validate in PDF format

  Scenario: claimaint's address is outside UK
    Given a claimant submitted an ET1 who live outside UK
    When the completed form is submitted
    Then  I can download the form and validate in PDF format

  Scenario: Claimant home postcode BS11DZ will be forwarded to Bristol office
    Given claimant home postcode 'BS1 1DZ' then submission office will be 'Bristol, Bristol Civil and Family Justice Centre, 2 Redcliff Street, Bristol, BS1 6GR'
    When the completed form is submitted 
    Then I can download the form and validate that the filename starts with '14'

  Scenario: Claimant's work address is unknown
    Given claimant work postcode 'Z1 2LL' then submission office will be 'Default, Alexandra House, 14-22 The Parsonage, Manchester M3 2JA'
    When the completed form is submitted
    Then I can download the form from the secondary queue and that the filename starts with '99'
