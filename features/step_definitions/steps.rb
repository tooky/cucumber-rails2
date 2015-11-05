TEMPLATE_DIR=File.join(File.expand_path("."), "test_support", "app_templates")

Given(/^a hello world rails application with cucumber-rails2 installed$/) do
  @app_dir = "hello_world"
  @template_file = File.join(TEMPLATE_DIR, "#{@app_dir}.rb")
  run_simple "bundle exec rails new hello_world --skip-test-unit --skip-spring -m #{@template_file}"
  cd @app_dir
end
