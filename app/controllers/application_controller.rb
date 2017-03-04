class ApplicationController < ActionController::Base
  # include HttpResponseConcern
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  before_action :require_admin_user!
  
  # rescue_from ActiveRecord::RecordNotFound, :with => :page_not_found
  # rescue_from StandardError, :with => :internal_server_error
  
  protected
  
  def require_admin_user!
    unless current_user.admin?
      request.referrer || root_path
    end
  end
  
  # def page_not_found
  #   render_404
  # end
  
  # def internal_server_error
  #   render_500
  # end
end
