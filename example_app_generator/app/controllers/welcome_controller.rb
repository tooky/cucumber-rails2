class WelcomeController < ApplicationController
  def error
    raise "An exception in the controller"
  end
end
