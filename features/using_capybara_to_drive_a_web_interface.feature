Feature: Using Capybara to drive a web interface

  [Capybara](http://jnicklas.github.io/capybara/) helps you test web
  applications by simulating how a user interacts with your application
  through a web browser.

  If Capybara is included in your `Gemfile` cucumber-rails will allow
  you to use the Capybara DSL within your step definitions.

  @capybara-installed
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

  Scenario: Warn developer when Capybara is not included
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

