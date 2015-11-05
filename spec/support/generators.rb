# From rspec-rails
# TODO: Add proper acreditation
module Cucumber
  module Rails
    module Specs
      module Generators
        module Macros
          # Tell the generator where to put its output (what it thinks of as
          # Rails.root)
          def set_default_destination
            destination File.expand_path("../../../tmp", __FILE__)
          end

          def setup_default_destination
            set_default_destination
            before { prepare_destination }
          end
        end

        def self.included(klass)
          klass.extend(Macros)
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include Cucumber::Rails::Specs::Generators, :type => :generator
end

