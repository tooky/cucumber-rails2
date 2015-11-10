Feature: Using Capybara to drive a web interface

  [Capybara](http://jnicklas.github.io/capybara/) helps you test web
  applications by simulating how a user interacts with your application
  through a web browser.

  If Capybara is included in your `Gemfile` cucumber-rails will allow
  you to use the Capybara DSL within your step definitions.

  By default, Capybara will use rack-test, to simulate a browser within
  the same process as your rails application. Using an `@javascript` tag
  you can have capybara use a real browser – allowing you to check the
  result of javascript interactions with your website.

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

  Scenario: Capybara provides an `@javascript` tag to run with a browser
    Given a file named "app/assets/javascripts/hello_world.js" with:
      """
      $(document).ready(function () {
        $("<h2>Hello, javascript</h2>").insertAfter("h1")
      })
      """
    And a file named "features/hello_world.feature" with:
      """
      Feature:
        @javascript
        Scenario:
          When the home page is open
          Then the JS message is visible
      """
    And a file named "features/step_definitions/steps.rb" with:
      """
      When(/^the home page is open$/) do
        visit("/")
      end

      Then(/^the JS message is visible$/) do
        fail "JavaScript doesn't work" unless page.has_content?("Hello, javascript")
      end
      """
    When I run `bundle exec cucumber -S`
    Then it should pass

  @capybara-not-installed
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

