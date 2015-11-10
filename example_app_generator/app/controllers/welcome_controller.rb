class WelcomeController < ApplicationController
  def error
    raise "An exception in the controller"
  end

  def data
    render :json => {'hello' => 'world'}.to_json
  end
end
