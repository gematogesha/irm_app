class SessionsController < ApplicationController

    add_flash_types :info, :error, :success

    def index
        @posts = Post.all.order(created_at: :desc).first(3) 
        @sliders = Slider.all 
    end

    def accept_cookies
		cookies[:cookie_policy] = { value: true, expires: 1.month }

        redirect_back(fallback_location: root_path)
	end



end
