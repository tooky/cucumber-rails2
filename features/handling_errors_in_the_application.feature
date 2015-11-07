Feature: Handling errors in the application

  By default, any exception happening in your Rails application will
  bubble up to Cucumber so that your scenario will fail. This is
  different from how your application behaves in the production
  environment, where an error page will be rendered instead.

  Sometimes we want to override this default behaviour and allow Rails
  to rescue exceptions and display an error page (just like when the app
  is running in production).  Typical scenarios where you want to do
  this is when you test your error pages.

  Background:
    Given a file named "features/step_definitions/steps.rb" with:
      """
      When(/^the error page is open$/) do
        visit("/error")
      end
      """

  Scenario: Errors bubble up to Cucumber
    Given a file named "features/hello_world.feature" with:
      """
      Feature:
        Scenario:
          When the error page is open
      """
    When I run `bundle exec cucumber`
    Then it should fail with:
      """
      An exception in the controller
      """

  Scenario: Use `@allow-rescue` tag to have Rails handle errors
    Given a file named "features/hello_world.feature" with:
      """
      Feature:
        @allow-rescue
        Scenario:
          When the error page is open
      """
    When I run `bundle exec cucumber`
    Then it should pass
