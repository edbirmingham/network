class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  before_action :require_admin_or_staff_user!
  
  protected
  
  def require_admin_or_staff_user!
    unless current_user.admin? or current_user.staff? or controller_name == 'dashboards'
      redirect_to root_path
    end
  end
end
