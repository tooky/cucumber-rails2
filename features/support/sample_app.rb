unless File.directory?('./tmp/example_app')
  system "rake generate:app"
end

Before do
  example_app_dir = File.expand_path('tmp/example_app')
  aruba_dir = File.expand_path('tmp/aruba')

  # Remove the previous aruba workspace.
  FileUtils.rm_rf(aruba_dir) if File.exist?(aruba_dir)

  # copy the workspace
  system('cp', '-r', example_app_dir, aruba_dir)

  # use Gemfile from the example app
  set_environment_variable("BUNDLE_GEMFILE", File.join(aruba_dir, "Gemfile"))
end

Before("@capybara-installed") do
  gem 'capybara', group: :test
end

