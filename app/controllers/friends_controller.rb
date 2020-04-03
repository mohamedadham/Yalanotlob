class FriendsController < ApplicationController
    def search
        query = params['input'];
        friends = User.where(["name LIKE :query", query: "%#{query}%"]);
        msg = { :status => "ok", :message => friends, :html => "<b>...</b>" }
        render :json => msg # don't do msg.to_json
    end
end
