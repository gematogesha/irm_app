class SessionsController < ApplicationController

    before_action :loggedin, only: [:destroy, :admin]
    before_action :set_all, only: %i[get_admin_list]
    before_action :set_session, only: %i[index]

    add_flash_types :info, :error, :success

    def index

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
    end

    def get_admin_list
        @page_title_text = "Панель администратора"

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

    def set_all
        @posts = Post.all.order(created_at: :desc)  
        @documents = Document.all
        @banners = Banner.all 
        @abouts = About.all 
        @leaders = Leader.all 
        @headers = Header.all 
        @themes = Theme.all 
        @activities = Activity.all
        @sciences = Science.all
        @products = Product.all
        @careers = Career.all
        @others = Other.all
    end

    def set_session
        @posts = Post.all.order(created_at: :desc).first(3) 
        @banners = Banner.all 
        @activities = Activity.all 
    end

end
