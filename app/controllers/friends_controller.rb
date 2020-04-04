class FriendsController < ApplicationController
    def search
        query = params['input'];
        friends = User.joins(:followers).where(["name LIKE :query", query: "%#{query}%"]).where.not(id: current_user.id);
        msg = { :status => "ok", :message => friends, :html => "<b>...</b>" }
        render :json => msg # don't do msg.to_json
    end
end
