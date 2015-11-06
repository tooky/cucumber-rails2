require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new(:features)

task :default => [:spec, :features]

def in_example_app(*command_opts)
  app_dir = './tmp/example_app'
  if Hash === command_opts.last
    opts = command_opts.pop
    app_dir = opts.fetch(:app_dir, app_dir)
  end
  Dir.chdir(app_dir) do
    Bundler.with_clean_env do
      sh *command_opts unless command_opts.empty?
      yield if block_given?
    end
  end
end

namespace :generate do
  desc "generate a fresh app with rspec installed"
  task :app do
    app_dir = File.expand_path('./tmp/example_app')

    sh "bundle exec rails new #{app_dir} --skip-javascript --skip-sprockets --skip-git --skip-test-unit --skip-bundle --template=example_app_generator/template.rb"

    Dir.chdir(app_dir) do
      application_file = File.read("config/application.rb")
      sh "rm config/application.rb"
      File.open("config/application.rb", "w") do |f|
        f.write application_file.gsub(
          "config.assets.enabled = true",
          "config.assets.enabled = false"
        )
      end
    end
  end
end
