begin
  require 'capybara/rails'
  require 'capybara/cucumber'
rescue LoadError
end

module Cucumber
  module Rails
    module World
      def visit(*)
        if defined?(super)
          super
        else
          raise Cucumber::Pending, "Capybara not loaded, please add it to your Gemfile:\n\ngem \"capybara\"\n\n"
        end
      end
    end
  end
end

World(Cucumber::Rails::World)
