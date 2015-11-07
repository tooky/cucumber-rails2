Feature: Handling errors in the application

  By default Rails will handle errors in the application and serve a 500
  page to the user. In the BDD workflow it is helpful to see the errors
  raised, rather than having a server error page returned.

  Scenario: Errors are raised by Cucumber
    Given a file named "features/hello_world.feature" with:
      """
      Feature:
        Scenario:
          When the error page is open
      """
    And a file named "features/step_definitions/steps.rb" with:
      """
      When(/^the error page is open$/) do
        visit("/error")
      end
      """
    When I run `bundle exec cucumber`
    Then it should fail with:
      """
      An exception in the controller
      """
