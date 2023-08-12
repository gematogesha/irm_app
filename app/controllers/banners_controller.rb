class BannersController < ApplicationController

    before_action :loggedin, only: %i[create new update edit destroy]
    before_action :model_name
    before_action :set_banner, only: %i[update show destroy edit]
    before_action :redirect, only: %i[show index]

    add_flash_types :info, :error, :success

    def create
        add_breadcrumb("Создать баннер")
        add_breadcrumb(@model_many, banners_path)
        @page_title_text = "Создать баннер"
        @banner = Banner.create(banner_params)
        if @banner.save
          redirect_to admin_path, success: "Баннер создан"
        else     
            render :new
        end
    end

    def new
        @banner = Banner.new
        add_breadcrumb("Создать баннер")
        @page_title_text = "Создать баннер"
    end

    def edit
        add_breadcrumb("Редактировать баннер")
        @page_title_text = "Редактировать баннер"  
    end


    def update      
        @page_title_text = "Редактировать баннер" 
        add_breadcrumb("Редактировать баннер") 
        @banner.update(banner_params)
        if @banner.update(banner_params)
            redirect_to admin_path, success: "Баннер обновлен"
        else 
            render :edit
        end
    end

    def destroy 
        @banner.destroy
        redirect_to admin_path, success: "Баннер удален"
    end
    

    private

    def banner_params
        params.require(:banner).permit(:title, :description, :link, :image)
    end
  
    def set_banner
        @banner = Banner.find(params[:id]) rescue not_found
    end

    def model_name
        @model_one = Banner.model_name.human
        @model_many = Banner.model_name.human(count: :many)
    end

    def redirect
        redirect_to admin_path
    end

end
