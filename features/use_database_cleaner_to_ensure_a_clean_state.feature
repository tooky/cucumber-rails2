Feature: Use database cleaner to ensure a clean state

  Scenario: Reset DB state between scenarios
    Given a file named "features/widgets.feature" with:
      """
      Feature:
        Background:
          Given there are 2 widgets

        Scenario:
          When 3 widgets are created
          Then there should be 5 widgets

        Scenario:
          When 2 widgets are created
          Then there should be 4 widgets
      """
    And a file named "features/step_definitions/steps.rb" with:
      """
      Given(/^there are (\d+) widgets$/) do |n|
        n.to_i.times do |i|
          Widget.create! :name => "Widget #{Widget.count + i}"
        end
      end
      When(/^(\d+) widgets are created$/) do |n|
        n.to_i.times do |i|
          Widget.create! :name => "Widget #{Widget.count + i}"
        end
      end
      Then(/^there should be (\d+) widgets$/) do |n|
        fail "expected #{n} widgets, but got #{Widget.count}" unless Widget.count == n.to_i
      end
      """
    When I run `bundle exec cucumber`
    Then it should pass

  @database-cleaner-not-installed
  Scenario: Database cleaner is not required
    Given a file named "features/posts.feature" with:
      """
      Feature:
        Scenario:
          When I do it
      """
    And a file named "features/step_definitions/posts_steps.rb" with:
      """
      When /^I do it$/ do
        visit '/'
      end
      """
    When I run `bundle exec cucumber`
    Then it should pass
