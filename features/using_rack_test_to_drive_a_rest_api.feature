Feature: Using rack-test to drive a REST API

  Rack::Test is a small, simple testing API for Rack apps. If you're
  application is providing a REST API, and you don't need to simulate
  a browser using Capybara, Cucumber-Rails makes the Rack::Test API
  available. This will allow you to test your API endpoints in-process.

  Scenario: Compare a JSON response
    Given a file named "features/hello_world.feature" with:
      """
      Feature:
        Scenario:
          When the client requests GET /data
          Then the response should be JSON:
            \"\"\"
            {
              "hello": "world"
            }
            \"\"\"
      """
    And a file named "features/step_definitions/steps.rb" with:
      """
      When /^the client requests GET (.*)$/ do |path|
        get(path)
      end

      Then /^the response should be JSON:$/ do |json|
        unless JSON.parse(last_response.body) == JSON.parse(json)
          fail "Unexpected JSON response:\n\n:#{last_response.body}"
        end
      end
      """
    When I run `bundle exec cucumber -S`
    Then it should pass

