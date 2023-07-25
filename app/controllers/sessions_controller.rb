class SessionsController < ApplicationController

    before_action :loggedin, only: [:destroy, :admin]

    add_flash_types :info, :error, :success

    def index
        @posts = Post.all.order(created_at: :desc).first(3) 
        @sliders = Slider.all 
    end

    def new

        add_breadcrumb("Вход")

        @page_title_text = "Вход"

        if session[:admin]
          redirect_to control_panel_path(subdomain: "admin")
        end 
    end
  
    def admin

        add_breadcrumb("Панель администратора")

        @page_title_text = "Панель администратора"
        
    end

    def create
        user_params = params.require(:sessions)
        
        email="admin@mail.ru"
        password="admin"
        
        #user = User.find_by(email: user_params[:email])&.authenticate(user_params[:password])
    
        #if user.present?
        if user_params[:email] == email and user_params[:password]==password
            session[:admin] = true
    
            redirect_to control_panel_path(subdomain: "admin"), info: "Вы вошли на сайт"
        else
            redirect_to login_path, error: "Неправельный email или пароль"
    
        end
    end
  
    def destroy
        session.destroy
    
        redirect_to root_path, info: "Вы вышли из аккаунта"
    end


    def accept_cookies
		cookies[:cookie_policy] = { value: true, expires: 1.month }

        redirect_back(fallback_location: root_path)
	end



end
