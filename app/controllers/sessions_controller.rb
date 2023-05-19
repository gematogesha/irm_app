class SessionsController < ApplicationController

    add_flash_types :info, :error, :success

    def index
        @posts = Post.all.order(created_at: :desc).first(3) 
        @sliders = Slider.all 
    end

    def accept_cookies
		cookies[:status] = true
	end

end
