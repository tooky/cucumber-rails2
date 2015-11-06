require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new(:features)

task :default => [:spec, :features]

namespace :generate do
  desc "generate a fresh app with rspec installed"
  task :app do
    app_dir = File.expand_path('./tmp/example_app')

    sh "bundle exec rails new #{app_dir} -f --skip-active-record --skip-javascript --skip-sprockets --skip-git --skip-test-unit --skip-bundle --template=example_app_generator/base_template.rb"

    Dir.chdir(app_dir) do
      Bundler.with_clean_env do
        sh "bundle install --gemfile ./Gemfile --path /Users/steve/Code/rspec/rspec-rails/../bundle --retry=3 --jobs=3"
        application_file = File.read("config/application.rb")
        sh "rm config/application.rb"
        File.open("config/application.rb", "w") do |f|
          f.write application_file.gsub(
            "config.assets.enabled = true",
            "config.assets.enabled = false"
          )
        end
        sh "bundle exec rake rails:template LOCATION='../../example_app_generator/app_template.rb'"
      end
    end
  end
end


namespace :clobber do
  desc "clobber the generated app"
  task :app do
    rm_rf "tmp/example_app"
  end
end

