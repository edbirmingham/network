class SurveysController < ApplicationController
  include MemberSearch
  
  def index
    @surveys = Survey.new(@current_user).find_all
  end

  def show
    @survey = Survey.new(@current_user).find(params[:id])
    @recipients = Survey.new(@current_user).recipients(params[:id])
  end
  
  def update
    Survey.new(@current_user).add_recipients(params[:id], filtered_members)
    redirect_to survey_path(params[:id])
  end
end
