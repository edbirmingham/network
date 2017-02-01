class CommonTasksController < ApplicationController
  before_action :set_common_task, only: [:show, :edit, :update, :destroy]

  # GET /common_tasks
  # GET /common_tasks.json
  def index
    @common_tasks = CommonTask.all
  end

  # GET /common_tasks/1
  # GET /common_tasks/1.json
  def show
  end

  # GET /common_tasks/new
  def new
    @common_task = CommonTask.new
  end

  # GET /common_tasks/1/edit
  def edit
  end

  # POST /common_tasks
  # POST /common_tasks.json
  def create
    @common_task = CommonTask.new(common_task_params)
    @common_task.user = current_user
    respond_to do |format|
      if @common_task.save
        format.html { redirect_to @common_task, notice: 'Common task was successfully created.' }
        format.json { render :show, status: :created, location: @common_task }
      else
        format.html { render :new }
        format.json { render json: @common_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /common_tasks/1
  # PATCH/PUT /common_tasks/1.json
  def update
    respond_to do |format|
      if @common_task.update(common_task_params)
        format.html { redirect_to @common_task, notice: 'Common task was successfully updated.' }
        format.json { render :show, status: :ok, location: @common_task }
      else
        format.html { render :edit }
        format.json { render json: @common_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /common_tasks/1
  # DELETE /common_tasks/1.json
  def destroy
    @common_task.destroy
    respond_to do |format|
      format.html { redirect_to common_tasks_url, notice: 'Common task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_common_task
      @common_task = CommonTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def common_task_params
      params.require(:common_task).permit(:name, :user_id)
    end
end
