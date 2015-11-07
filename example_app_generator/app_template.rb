DEFAULT_SOURCE_PATH = File.expand_path('..', __FILE__)

def source_paths
  @__source_paths__ ||= [DEFAULT_SOURCE_PATH]
end

generate('cucumber:install')

route "root to: 'welcome#index'"
route "get '/error', to: 'welcome#error'"
copy_file "app/controllers/welcome_controller.rb"
copy_file "app/views/welcome/index.html.erb"
