class NetworkEventsController < ApplicationController
  before_action :set_network_event, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /network_events
  # GET /network_events.json
  # GET /network_events.csv
  def index
    @network_events = filtered_events
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
        if create_another
          format.html { redirect_to new_network_event_path, alert: 'Network event was successfully created.' }
          format.json { render :new, status: :created, location: new_network_event_path }
        else
          format.html { redirect_to @network_event, notice: 'Network event was successfully created.' }
          format.json { render :show, status: :created, location: @network_event }
        end
        #format.html { redirect_to @network_event, notice: 'Network event was successfully created.' }
        #format.json { render :show, status: :created, location: @network_event }
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
  
  def create_another
    params[:commit] == "Save & Create Another"
  end
  
  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_network_event
      @network_event = NetworkEvent.find(params[:id])
    end
    
    def filtered_events
      events = NetworkEvent.
        includes(:program, :location, :organizations, :volunteers).
        order(sort_column + " " + sort_direction)
        
      # Filter events by scheduled date.
      if params[:start_date].present? && params[:end_date].present?
        events = events.in_date_range( params[:start_date], params[:end_date])
      else
        events = events.default_date_range
      end
      
      # Filter events by cohort.
      if params[:cohort_ids].present?
        events = events.
          joins(:cohort_assignments).
          where(cohort_assignments: {cohort_id: params[:cohort_ids]})
      end
          
      # Filter events by graduating class.
      if params[:graduating_class_ids].present?
        events = events.
          joins(:graduating_class_assignments).
          where(graduating_class_assignments: {graduating_class_id: params[:graduating_class_ids]})
      end
      
      # Filter events by program
      if params[:program_ids].present?
        events = events.
          where(:program_id => params[:program_ids])
      end
      
      # Filter events by school.
      if params[:school_ids].present?
        events = events.
          joins(:school_assignments).
          where(school_assignments: {school_id: params[:school_ids]})
      end
          
      # Filter events by organization
      if params[:organization_ids].present?
        events = events.
          joins(:organization_assignments).
          where(organization_assignments: {organization_id: params[:organization_ids]})
      end
      
      events
    end
    
    def sort_column
      if %w[location program organization].include? params[:sort]
        params[:sort].pluralize + ".name"
      else
        NetworkEvent.column_names.include?(params[:sort]) ? params[:sort] : "scheduled_at"
      end
    end
    
    def sort_direction
      # if no order direction is selected, default to ascending
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def network_event_params
      params.require(:network_event).permit(
        :name, 
        :program_id, 
        :location_id, 
        :scheduled_at, 
        :duration, 
        :needs_transport, 
        :transport_ordered_on,
        :notes,
        :organization_ids => [], 
        :site_contact_ids => [],
        :school_contact_ids => [],
        :volunteer_ids => [],
        :graduating_class_ids => [],
        :school_ids => [],
        :cohort_ids => []
      )
    end
end
