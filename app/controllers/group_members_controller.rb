class GroupMembersController < ApplicationController

    def create
        @user = User.find_by(email: params[:email])
        if @user.nil?
            flash[:group_member_errors] = ["No user exists with this email"]
        elsif @user.id == current_user.id
            flash[:group_member_errors] = ["You can't add yourself to the group"]
        else
            @group_member = GroupMember.find_by(user_id: @user.id, group_id: params[:group_id])
            if @group_member.nil?
                @friend = Friend.find_by(user_id: current_user.id, friend_id: @user.id)
                unless @friend.nil?
                    @group_member = GroupMember.create(user_id: @user.id, group_id: params[:group_id])
                    unless @group_member.persisted?
                        flash[:group_member_errors] = @group_member.errors.full_messages
                    end
                else
                    flash[:group_member_errors] = ["User isn't a friend"]
                end
            else
                flash[:group_member_errors] = ["User already exist in the group"]
            end
        end
        redirect_to group_url(:id => params[:group_id])
    end

    def destroy
        @group = Group.find_by(id: params[:id], user_id: current_user.id)
        unless @group.nil?
            @members = GroupMember.where(group_id: params[:id], user_id: params[:user_id])
            @members.destroy_all
            redirect_to group_url(params[:id])
        else
            flash[:group_error] = "You can't delete this group"
            redirect_to :groups
        end
    end

end
