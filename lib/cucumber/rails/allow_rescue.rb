ActionController::Base.class_eval do
  cattr_accessor :allow_rescue
end

ActionDispatch::ShowExceptions.class_eval do
  alias __cucumber_orig_call__ call

  def call(env)
    env['action_dispatch.show_exceptions'] = !!ActionController::Base.allow_rescue
    __cucumber_orig_call__(env)
  end
end

Before('@allow-rescue') do
  @__orig_allow_rescue = ActionController::Base.allow_rescue
  ActionController::Base.allow_rescue = true
end

After('@allow-rescue') do
  ActionController::Base.allow_rescue = @__orig_allow_rescue
end
