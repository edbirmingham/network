class NetworkEventsController < ApplicationController
  before_action :set_network_event, only: [:show, :edit, :update, :destroy]

  # GET /network_events
  # GET /network_events.json
  def index
    if params[:start_date].present? && params[:end_date].present?
      @network_events = NetworkEvent.in_date_range( params[:start_date], params[:end_date])
    else
      @network_events = NetworkEvent.default_date_range
    end
  end

  # GET /network_events/1
  # GET /network_events/1.json
  def show
  end

  # GET /network_events/new
  def new
    @network_event = NetworkEvent.new
  end

  # GET /network_events/1/edit
  def edit
  end

  # POST /network_events
  # POST /network_events.json
  def create
    @network_event = NetworkEvent.new(network_event_params)
    @network_event.user = current_user
    respond_to do |format|
      if @network_event.save
        if params[:commit] == 'Save & Create Another'
          format.html { redirect_to new_network_event_path, alert: 'Network event was successfully created.' }
          format.json { render :new, status: :created, location: @network_event }
        elsif params[:commit] == 'Create Event'
          format.html { redirect_to @network_event, notice: 'Network event was successfully created.' }
          format.json { render :show, status: :created, location: @network_event }
        end
      else
        format.html { render :new }
        format.json { render json: @network_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /network_events/1
  # PATCH/PUT /network_events/1.json
  def update
    respond_to do |format|
      if @network_event.update(network_event_params)
        format.html { redirect_to @network_event, notice: 'Network event was successfully updated.' }
        format.json { render :show, status: :ok, location: @network_event }
      else
        format.html { render :edit }
        format.json { render json: @network_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /network_events/1
  # DELETE /network_events/1.json
  def destroy
    @network_event.destroy
    respond_to do |format|
      format.html { redirect_to network_events_url, notice: 'Network event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network_event
      @network_event = NetworkEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def network_event_params
      params.require(:network_event).permit(
        :name, 
        :program_id, 
        :location_id, 
        :scheduled_at, 
        :duration, 
        :organization_ids => [], 
        :site_contact_ids => [],
        :school_contact_ids => [],
        :volunteer_ids => [],
        :graduating_class_ids => []
      )
    end
end
