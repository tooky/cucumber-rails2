require 'cucumber/rails/capybara'
require 'cucumber/rails/allow_rescue'

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
