@announce
Feature: Working with Web Pages

  Scenario: Visit a page with capybara
    Given a hello world rails application with cucumber-rails2 installed
    And a file named "features/hello_world.feature" with:
      """
      Feature: Hello World
        Scenario: Say Hello
          When the home page is open
          Then the greeting should be "Hello, world!"
      """
    And a file named "features/support/rails.rb" with:
      """
      ENV['RAILS_ENV'] ||= 'test'
      require File.expand_path('../../../config/environment', __FILE__)
      require 'cucumber/rails'
      require 'capybara/rails'
      require 'capybara/cucumber'
      """
    And a file named "features/support/steps.rb" with:
      """
      When(/^the home page is open$/) do
        visit("/")
      end

      Then(/^the greeting should be "([^"]*)"$/) do |greeting|
        page.find("h1")
      end
      """
    When I run `bundle exec cucumber`
    Then the feature should pass
