class GroupsController < ApplicationController
    def index
        @groups = Group.where(user_id: current_user.id)
    end

    def create
        @group = Group.create(name: params[:name], user_id: current_user.id)
        if @group.persisted?  
            redirect_to :groups 
        else
            flash[:group_errors] = @group.errors.full_messages
            redirect_to :groups
        end
    end

    def show
        @groups = Group.where(user_id: current_user.id)
        @group = Group.find_by(id: params[:id], user_id: current_user.id)
        if @group.nil?
            flash[:group_error] = "No Group exists with this id"
            redirect_to :groups
        else
            @members = GroupMember.where(group_id: params[:id])
            @users = @members.map{
                |member| User.find(member.user_id)
            }
            @data = []
            @data << @group
            @data << @groups
            @data << @users
        end

    end

    def destroy
        @group = Group.find_by(id: params[:id], user_id: current_user.id)
        @group.destroy
        if @group.destroyed
            redirect_to :groups
        else
            flash[:group_error] = "You can't delete this group"
            redirect_to :groups
    end
end
