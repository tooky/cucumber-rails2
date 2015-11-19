require 'cucumber/rails/allow_rescue'
require 'cucumber/rails/capybara'
require 'cucumber/rails/database'

require 'rack/test'
module Cucumber
  module Rails
    module RackTest
      include Rack::Test::Methods

      def app
        Rack::Builder.new do
          map "/" do
            run ::Rails.application
          end
        end.to_app
      end
    end
  end
end

World(Cucumber::Rails::RackTest)

begin
  require 'database_cleaner'

  Before('@javascript') do
    Cucumber::Rails::Database.before_js
  end

  Before('~@javascript') do
    Cucumber::Rails::Database.before_non_js
  end

  After do
    Cucumber::Rails::Database.after
  end

  Before do
    DatabaseCleaner.start
  end

  After do
    DatabaseCleaner.clean
  end

rescue LoadError => _ignore_if_database_cleaner_not_present
end
