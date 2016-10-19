class NetworkActionsController < ApplicationController
  before_action :set_network_action, only: [:show, :edit, :update, :destroy]

  # GET /network_actions
  # GET /network_actions.json
  # GET /network_actions.csv
  def index
    @network_actions = NetworkAction.all
  end

  # GET /network_actions/1
  # GET /network_actions/1.json
  def show
  end

  # GET /network_actions/new
  def new
    @network_action = NetworkAction.new
  end

  # GET /network_actions/1/edit
  def edit
  end

  # POST /network_actions
  # POST /network_actions.json
  def create
    @network_action = NetworkAction.new(network_action_params)
    @network_action.user = current_user

    respond_to do |format|
      if @network_action.save
        format.html { redirect_to @network_action, notice: 'Network action was successfully created.' }
        format.json { render :show, status: :created, location: @network_action }
      else
        format.html { render :new }
        format.json { render json: @network_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /network_actions/1
  # PATCH/PUT /network_actions/1.json
  def update
    respond_to do |format|
      if @network_action.update(network_action_params)
        format.html { redirect_to @network_action, notice: 'Network action was successfully updated.' }
        format.json { render :show, status: :ok, location: @network_action }
      else
        format.html { render :edit }
        format.json { render json: @network_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /network_actions/1
  # DELETE /network_actions/1.json
  def destroy
    @network_action.destroy
    respond_to do |format|
      format.html { redirect_to network_actions_url, notice: 'Network action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network_action
      @network_action = NetworkAction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def network_action_params
      params.require(:network_action).permit(:actor_id, :network_event_id, :action_type, :description, :member_ids => [])
    end
end
