class ExtracurricularActivitiesController < ApplicationController
  before_action :set_extracurricular_activity, only: [:show, :edit, :update, :destroy]

  # GET /extracurricular_activities
  # GET /extracurricular_activities.json
  def index
    @extracurricular_activities = ExtracurricularActivity.all
  end

  # GET /extracurricular_activities/1
  # GET /extracurricular_activities/1.json
  def show
  end

  # GET /extracurricular_activities/new
  def new
    @extracurricular_activity = ExtracurricularActivity.new
  end

  # GET /extracurricular_activities/1/edit
  def edit
  end

  # POST /extracurricular_activities
  # POST /extracurricular_activities.json
  def create
    @extracurricular_activity = ExtracurricularActivity.new(extracurricular_activity_params)
    @extracurricular_activity.user = current_user
    
    respond_to do |format|
      if @extracurricular_activity.save
        format.html { redirect_to @extracurricular_activity, notice: 'Extracurricular activity was successfully created.' }
        format.json { render :show, status: :created, location: @extracurricular_activity }
      else
        format.html { render :new }
        format.json { render json: @extracurricular_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extracurricular_activities/1
  # PATCH/PUT /extracurricular_activities/1.json
  def update
    respond_to do |format|
      if @extracurricular_activity.update(extracurricular_activity_params)
        format.html { redirect_to @extracurricular_activity, notice: 'Extracurricular activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @extracurricular_activity }
      else
        format.html { render :edit }
        format.json { render json: @extracurricular_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extracurricular_activities/1
  # DELETE /extracurricular_activities/1.json
  def destroy
    @extracurricular_activity.destroy
    respond_to do |format|
      format.html { redirect_to extracurricular_activities_url, notice: 'Extracurricular activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extracurricular_activity
      @extracurricular_activity = ExtracurricularActivity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extracurricular_activity_params
      params.require(:extracurricular_activity).permit(:name)
    end
end
