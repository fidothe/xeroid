Feature: Posting a single invoice
  As a user of Xero API
  I want to post an invoice to Xero
  In order to get it into Xero

  @vcr
  Scenario: Posting a new, minimal, draft invoice
    Given a valid minimal draft invoice object
    When I post it to Xero
    Then I should get confirmation it was posted successfully
      And get back an invoice object with IDs

  @vcr
  Scenario: Posting a new, invalid, invoice
    Given an invalid draft invoice object
    When I post it to Xero
    Then I should get an API exception object back
