Feature: Fetching all Tax Rates
  As a user of Xero API
  I want to fetch all my organisations tax rates
  In order to correctly specify tax rates in my invoices

  @vcr
  Scenario: Fetching tax rates
    When I fetch all tax rates from Xero
    Then I should get back valid tax rate objects
