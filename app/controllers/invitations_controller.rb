class InvitationsController < ApplicationController
  
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]



  def update
   
    @invitation = Invitation.find params[:id]
    @title = 'Shattered View: A Novel on Rails'
    @notice=""
    if params[:commit] == "Accept"    
      @invitation.status="accepted"
      @notice = 'Invitation was successfully accepted.' 
    else
      @invitation.status="rejected"
      @notice = 'Invitation was rejected.' 
    end
    respond_to do |format|
      if @invitation.update(food_item_params)
        format.html { redirect_to notifications_path, notice: @notice,:locals => {:title => 'Some text'}}
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
    @title="hiii"
 end

 private
 def set_invitation
  @invitation = Invitation.find params[:id]
end
 def food_item_params
  @invitation = Invitation.find params[:id]

   params.permit(:id) 
 end
end