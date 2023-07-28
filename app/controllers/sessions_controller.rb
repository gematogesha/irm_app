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
          redirect_to control_panel_url(subdomain: "admin")
        end 
    end
  
    def admin
        @page_title_text = "Панель администратора"
        @posts = Post.all.order(created_at: :desc)  
        @documents = Document.all
    end

    def create
        if authenticate?
            session[:admin] = { value: true, domain: :all }
            redirect_to control_panel_url(subdomain: "admin"), info: "Вы вошли на сайт"
        else
            redirect_to admin_path, error: "Неправельный email или пароль"
    
        end
    end
  
    def destroy
        session.destroy
        redirect_to admin_path, info: "Вы вышли из аккаунта"
    end

    def accept_cookies
		cookies[:cookie_policy] = { value: true, expires: 1.month, domain: :all }
        redirect_back(fallback_location: root_path)
	end

    private

    def authenticate?
        user_params = params.require(:sessions)
        email="admin@mail.ru"
        password="admin"
        if user_params[:email] == email and user_params[:password]==password
            true
        end

    end


end
