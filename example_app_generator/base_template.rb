cucumber_rails_repo_path = File.expand_path("../../", __FILE__)
rails_dependencies_gemfile = File.join(cucumber_rails_repo_path, 'Gemfile-rails-dependencies')

in_root do
  # Remove the existing rails version so we can properly use master or other
  # edge branches
  gsub_file 'Gemfile', /^.*\bgem 'rails.*$/, ''

  # Use our version of RSpec and Rails
  append_to_file 'Gemfile', <<-EOT.gsub(/^ +\|/, '')
    |gem 'cucumber-rails',
    |    :path => '#{cucumber_rails_repo_path}',
    |    :groups => [:development, :test],
    |    :require => false
    |gem 'capybara', "~> 2.5"
    |gem 'selenium-webdriver'
    |gem 'database_cleaner'
    |eval_gemfile '#{rails_dependencies_gemfile}'
  EOT
end
