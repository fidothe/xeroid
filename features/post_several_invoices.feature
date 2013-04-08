Feature: Posting several invoices
  As a user of the Xero API
  I want to post several invoices to Xero in a single batch
  In order to get them into Xero as quickly as possible

  @vcr
  Scenario: Posting new, minimal, draft invoices
    Given several valid minimal draft invoice objects
    When I post them to Xero
    Then I should get confirmation they were posted successfully
      And get back invoice objects with IDs

  @vcr
  Scenario: Posting several minimal draft invoices together with one that's invalid
    Given several valid minimal draft invoice objects
      And an invalid draft invoice object
    When I post them to Xero
    Then I should get confirmation that the valid invoices were posted successfully
      And get back invoice objects with IDs for the valid invoices
      And confirmation that the invalid invoice caused a problem
      And an API exception object for the invalid invoice
