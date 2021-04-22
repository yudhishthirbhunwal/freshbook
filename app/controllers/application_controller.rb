class ApplicationController < ActionController::Base
  def welcome
    render html: 'Welcome to FreshBook!!'
  end
end
