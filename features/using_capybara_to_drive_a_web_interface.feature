Feature: Using capybara to drive a web interface

  Scenario: Steps are skipped without Capybara
    Given a file named "features/hello_world.feature" with:
      """
      Feature:
        Scenario:
          When the home page is open
      """
    And a file named "features/step_definitions/steps.rb" with:
      """
      When(/^the home page is open$/) do
        visit("/")
      end
      """
    When I run `bundle exec cucumber -S`
    Then it should fail with:
      """
      Capybara not loaded, please add it to your Gemfile
      """

  @capybara
  Scenario: Visit a page with capybara
    Given a file named "features/hello_world.feature" with:
      """
      Feature:
        Scenario:
          When the home page is open
      """
    And a file named "features/step_definitions/steps.rb" with:
      """
      When(/^the home page is open$/) do
        visit("/")
      end
      """
    When I run `bundle exec cucumber -S`
    Then it should pass
