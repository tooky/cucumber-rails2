require "action_controller/railtie"

# Load rspec-rails adapters early in the process
require 'rspec/rails/adapters'

# Load the rspec-rails parts we need
require 'rspec/rails/view_rendering'
require 'rspec/rails/fixture_support'
require 'rspec/rails/example'

require 'ammeter/init'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
