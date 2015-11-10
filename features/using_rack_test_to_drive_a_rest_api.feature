Feature: Using rack-test to drive a REST API

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

