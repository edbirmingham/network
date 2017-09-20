class WelcomeController < ApplicationController
  skip_before_action :require_admin_or_staff_user!
  
  def index
  end
end
