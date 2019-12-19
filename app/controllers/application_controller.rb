class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_admin
    redirect_to root_url, :alert => "Access denied." unless current_user.admin
  end
end
