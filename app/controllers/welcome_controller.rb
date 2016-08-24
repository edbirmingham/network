class WelcomeController < ApplicationController
  skip_filter :require_admin_user!
  
  def index
  end
end
