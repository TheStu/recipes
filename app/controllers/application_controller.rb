class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_registration_path
    flash[:error] = "Please sign in or sign up before continuing"
  end
end
