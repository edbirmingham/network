class SurveysController < ApplicationController
  def index
    @surveys = Survey.new(@current_user).find_all
  end

  def show
    @survey = Survey.new(@current_user).find(params[:id])
    @recipients = Survey.new(@current_user).recipients(params[:id])
  end
end
