class SessionsController < ApplicationController

    def index
        @posts = Post.all.order(created_at: :desc).first(3) 
    end

end
