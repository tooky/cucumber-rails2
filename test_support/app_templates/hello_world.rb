gem_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))

gem 'cucumber-rails2' , group: :test, require: false, path: gem_path
generate(:"cucumber:install")
