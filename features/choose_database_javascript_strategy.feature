Feature: Choose javascript database strategy

  When running a scenario with the @javascript tag, Capybara will fire
  up a web server in the same process in a separate thread to your
  cukes. By default, this means ActiveRecord will give it a separate
  database connection, which in turn means data you put into your
  database from Cucumber step definitions (e.g. using FactoryGirl) won't
  be visible to the web server until the database transaction is
  committed.

  So if you use a transaction strategy for cleaning up your database at
  the end of a scenario, it won't work for javascript scenarios by
  default.

  There are two ways around this. One is to switch to a truncation
  strategy for javascript scenarios. This is slower, but more reliable.

  Right now, the default behavior is to use truncation, but you can
  override this by telling cucumber-rails which strategy to use for
  javascript scenarios.

  The deletion strategy can be quicker for situations where truncation
  causes locks which has been reported by some Oracle users.

  Background:
    Given a file named "features/step_defintions/steps.rb" with:
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
      Then /^the DatabaseCleaner strategy should be (\w+)$/ do |strategy_name|
        unless DatabaseCleaner.connections.first.strategy.to_s =~ /#{strategy_name}/i
         fail "expected #{strategy_name}, but got #{DatabaseCleaner.connections.first.strategy}"
        end
      end
      """

  @announce
  Scenario: Use truncation strategy for `@javascript` scenarios
    Given a file named "features/support/database_env.rb" with:
      """
      DatabaseCleaner.strategy = :transaction
      Cucumber::Rails::Database.javascript_strategy = :truncation
      """
    And a file named "features/widgets.feature" with:
      """
      Feature:
        Background:
          Given there are 2 widgets
        @javascript
        Scenario:
          Then the DatabaseCleaner strategy should be truncation
          When 3 widgets are created
          Then there should be 5 widgets
        @javascript
        Scenario:
          Then the DatabaseCleaner strategy should be truncation
          And there should be 2 widgets
        Scenario:
          Then the DatabaseCleaner strategy should be transaction
          And there should be 2 widgets
      """
    When I run `bundle exec cucumber`
    Then it should pass

  Scenario: Set the strategy to deletion and run a javascript scenario.
    Given a file named "features/support/database_env.rb" with:
      """
      Cucumber::Rails::Database.javascript_strategy = :deletion
      """
    And a file named "features/widgets.feature" with:
      """
      @javascript
      Feature:
        Background:
          Given there are 2 widgets

        Scenario:
          When 3 widgets are created
          Then there should be 5 widgets

        Scenario:
          Then there should be 2 widgets
      """
    When I run `bundle exec cucumber`
    Then it should pass

  Scenario: Set the strategy to truncation with an except option and run a javascript scenario.
    Given I append to "features/env.rb" with:
      """
     Cucumber::Rails::Database.javascript_strategy = :truncation, {:except=>%w[widgets]}
      """
    And a file named "features/widgets.feature" with:
      """
      @javascript
      Feature:
        Scenario:
          When 3 widgets are created
          Then there should be 3 widgets

        Scenario:
          When 2 widgets are created
          Then there should be 5 widgets
      """
    When I run `bundle exec cucumber`
    Then it should pass
