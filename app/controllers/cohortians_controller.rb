class CohortiansController < ApplicationController
  before_action :set_cohort, only: [:create, :destroy]

  # POST /cohorts
  # POST /cohorts.json
  def create
    params[:member_ids].each do |member_id|
      Cohortian.where(cohort: @cohort, member_id: member_id).first_or_create
    end

    redirect_to @cohort
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cohort
    @cohort = Cohort.find(params[:cohort_id])
  end

end