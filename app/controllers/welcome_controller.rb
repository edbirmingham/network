class WelcomeController < ApplicationController
  skip_before_action :require_admin_user!
  
  def index
  end
end
