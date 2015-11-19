module Cucumber
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def copy_rails_support
        copy_file "rails.rb", "features/support/env.rb"
      end

    end
  end
end
