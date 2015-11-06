DEFAULT_SOURCE_PATH = File.expand_path('..', __FILE__)

def source_paths
  @__source_paths__ ||= [DEFAULT_SOURCE_PATH]
end

gem_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))

gem 'cucumber-rails2', group: :test, require: false, path: gem_path

generate(:"cucumber:install")

route "root to: 'welcome#index'"
copy_file "app/controllers/welcome_controller.rb"
