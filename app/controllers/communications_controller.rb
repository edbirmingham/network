class CommunicationsController < ApplicationController
  before_action :set_member, only: [:new, :show, :edit, :update, :destroy]
  before_action :set_communication, only: [:show, :edit, :update, :destroy]

  # GET members/1/communications/1
  # GET members/1/communications/1.json
  def show
  end

  # GET members/1/communications/new
  def new
    @communication = Communication.new
  end

  # GET /communications/1/edit
  def edit
  end

  # POST members/1/communications
  # POST members/1/communications.json
  def create
    @member = Member.find(params[:member_id])
    @communication = Communication.new(communication_params)
    @communication.member_id = @member.id
    @communication.user = current_user
    respond_to do |format|
      if @communication.save
        format.html { redirect_to member_communication_path(@member, @communication), notice: 'Communication was successfully created.' }
        format.json { render :show, status: :created, location: @communication }
      else
        format.html { render :new }
        format.json { render json: @communication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT members/1/communications/1
  # PATCH/PUT members/1/communications/1.json
  def update
    respond_to do |format|
      if @communication.update(communication_params)
        format.html { redirect_to member_communication_path(@member, @communication), notice: 'Communication was successfully updated.' }
        format.json { render :show, status: :ok, location: @communication }
      else
        format.html { render :edit }
        format.json { render json: @communication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE members/1/communications/1
  # DELETE members/1/communications/1.json
  def destroy
    @communication.destroy
    respond_to do |format|
      format.html { redirect_to @member, notice: 'Communication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_communication
      @communication = Communication.find(params[:id])
    end

    def set_member
      @member = Member.find(params[:member_id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def communication_params
      params.require(:communication).permit(:kind, :notes, :member_id, :user_id, :contacted_on)
    end
end
