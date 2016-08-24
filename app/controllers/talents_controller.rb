class TalentsController < ApplicationController
  before_action :set_talent, only: [:show, :edit, :update, :destroy]

  # GET /talents
  # GET /talents.json
  def index
    @talents = Talent.order(:name)
  end

  # GET /talents/1
  # GET /talents/1.json
  def show
  end

  # GET /talents/new
  def new
    @talent = Talent.new
  end

  # GET /talents/1/edit
  def edit
  end

  # POST /talents
  # POST /talents.json
  def create
    @talent = Talent.new(talent_params)
    @talent.user = current_user

    respond_to do |format|
      if @talent.save
        format.html { redirect_to @talent, notice: 'Talent was successfully created.' }
        format.json { render :show, status: :created, location: @talent }
      else
        format.html { render :new }
        format.json { render json: @talent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /talents/1
  # PATCH/PUT /talents/1.json
  def update
    respond_to do |format|
      if @talent.update(talent_params)
        format.html { redirect_to @talent, notice: 'Talent was successfully updated.' }
        format.json { render :show, status: :ok, location: @talent }
      else
        format.html { render :edit }
        format.json { render json: @talent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /talents/1
  # DELETE /talents/1.json
  def destroy
    @talent.destroy
    respond_to do |format|
      format.html { redirect_to talents_url, notice: 'Talent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_talent
      @talent = Talent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def talent_params
      params.require(:talent).permit(:name)
    end
end
