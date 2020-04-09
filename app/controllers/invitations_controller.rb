class InvitationsController < ApplicationController
  
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]



  def update
    @invitation = Invitation.find params[:id]
    @notice=""
    if params[:commit] == "Accept"   
      @invitation.status="accepted"
      @notice = 'Invitation was successfully accepted.' 
      if params[:commit] == "Reject"   
        @invitation.status="rejected"
        @notice = 'Invitation was rejected.' 
      end

      respond_to do |format|
        if @invitation.update(invitations_params)
          format.html { redirect_to notifications_path, notice: @notice}
          format.json { render :show, status: :ok, location: @notification }
        else
          format.html { render :edit }
          format.json { render json: @notification.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.delete
    redirect_to new_order_detail_path
  end


 private

 def set_invitation
  @invitation = Invitation.find(params[:id])
 end

 def invitations_params
   params.permit(:id) 
 end

end
