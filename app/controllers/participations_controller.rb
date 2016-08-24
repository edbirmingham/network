class ParticipationsController < ApplicationController
  def destroy
    @participation = Participation.find(params[:id])

    if @participation.destroy
      respond_to do |format|
        format.html do
          redirect_to(
            member_url(@participation.member),
            notice: 'Participation was successfully destroyed.'
          )
        end
        format.json { head :no_content }
      end
    end
  end
end
