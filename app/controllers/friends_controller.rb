class FriendsController < ApplicationController
    def search
        query = params['input'];
        friends = User.joins(:followers).where(["name LIKE :query", query: "%#{query}%"]).where.not(id: current_user.id);
        msg = { :status => "ok", :message => friends, :html => "<b>...</b>" }
        render :json => msg # don't do msg.to_json
    end

    def searchByMail
        query = params['input'];
        friends = Friend.where(["email LIKE :query", query: "%#{query}%"]).where.not(id: current_user.id);
        msg = { :status => "ok", :message => friends, :html => "<b>...</b>" }
        render :json => msg # don't do msg.to_json
    end

    def new
        @friends = User.joins(:followers).order(created_at: :DESC)
    end
end
