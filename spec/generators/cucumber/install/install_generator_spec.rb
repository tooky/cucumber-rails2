require 'generators/cucumber/install/install_generator'
require 'support/generators'

RSpec.describe Cucumber::Generators::InstallGenerator, :type => :generator do
  setup_default_destination

  def content_for(file_name)
    File.read(file(file_name))
  end

  let(:rails_support) { content_for("features/support/env.rb") }

  it "generates features/support/env.rb" do
    generator_command_notice = /This file is generated by cucumber-rails/m
    run_generator
    expect(rails_support).to match(generator_command_notice)
  end
end
