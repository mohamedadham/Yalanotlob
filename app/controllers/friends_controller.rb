class FriendsController < ApplicationController
    def search
        query = params['input'];
        friends = User.joins(:followers).where(["name LIKE :query", query: "%#{query}%"]).where.not(id: current_user.id);

        if friends.length() == 0
            groups = Group.where(["name LIKE :query", query: "%#{query}%"])
            msg = { :status => "ok", :message => groups, :type => "group" }
        else
            msg = { :status => "ok", :message => friends, :type => "friend" }
        end
        
        render :json => msg
    end

    def searchByMail
        query = params['input'];
        sql = "Select * from users where email like '%#{query}%' AND id != #{current_user.id} AND id NOT IN (select friend_id from friends where user_id = #{current_user.id})"
        friends = ActiveRecord::Base.connection.execute(sql)
        msg = { :status => "ok", :message => friends }
        render :json => msg 
    end

    def new
        @friend = Friend.new
        @friends = User.joins(:followers).where('friends.user_id = ?', current_user.id).to_a
        @following = User.joins(:following).where('friends.friend_id = ?', current_user.id)

        @following.each { |friend|
            @friends.push friend
        }
    end

    def create
        @user = User.where("email = ?", params['email']).first

        alreadyFollower = Friend.where("user_id = ?", current_user.id).where("friend_id = ?", @user.id).first
        alreadyFollowing = Friend.where("user_id = ?", @user.id).where("friend_id = ?", current_user.id).first
        puts alreadyFollower
        puts alreadyFollowing
        if alreadyFollower != nil || alreadyFollowing != nil
            message = "You already are friends"
            redirect_to "/friends/new", :flash => { :error => message }
            return
        end

        @friend = Friend.new
        @friend.user_id = current_user.id
        if @user != nil
            if(current_user.id != @user.id)
                @friend.friend_id = @user.id
            else
                message = "You can not add yourself as a friend!"
                redirect_to "/friends/new", :flash => { :error => message }
                return
            end
        end
        
        if(@friend.save)
            message = "You are now friends"
            redirect_to "/friends/new", :flash => { :success => message }
        else
            message = "Please select user first"
            redirect_to "/friends/new", :flash => { :error => message }
        end
        
    end

    def destroy
        @friend = Friend.where("user_id = ?", current_user.id).where("friend_id = ?", params[:id]).first

        if(@friend != nil)
            @friend.destroy
        end

        @friend = Friend.where("user_id = ?", params[:id]).where("friend_id = ?", current_user.id).first

        if(@friend != nil)
            @friend.destroy
        end

        message = "Unfriended successfully"
        redirect_to "/friends/new", :flash => { :success => message }
    end
end
