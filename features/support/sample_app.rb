unless File.directory?('./tmp/example_app')
  system "rake generate:app"
end

Before do
  example_app_dir = 'tmp/example_app'
  aruba_dir = 'tmp/aruba'

  # Remove the previous aruba workspace.
  FileUtils.rm_rf(aruba_dir) if File.exist?(aruba_dir)

  # copy the workspace
  system('cp', '-r', example_app_dir, aruba_dir)
end

Before("@capybara") do
  gem 'capybara', group: :test
end

