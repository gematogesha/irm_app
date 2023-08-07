class ThemesController < ApplicationController

    before_action :loggedin, only: %i[create new update edit destroy]
    before_action :model_name
    before_action :set_theme, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def create
        add_breadcrumb("Создать тему")
        @page_title_text = "Создать тему"
        @theme = Theme.create(theme_params)
        if @theme.save
          redirect_to admin_path, success: "Тема создана"
        else     
            render :new
        end
    end

    def new
        @theme = Theme.new
        add_breadcrumb("Создать тему")
        @page_title_text = "Создать тему"

    end

    def edit
        add_breadcrumb("Редактировать тему")
        @page_title_text = "Редактировать тему"  
    end

    def update
        add_breadcrumb("Редактировать тему")
        @page_title_text = "Редактировать тему"  
        @theme.update(theme_params)
        if @theme.update(theme_params)
            redirect_to admin_path, success: "Тема обновлена"
        else 
            render :edit
        end
    end

    def destroy 
        @theme.destroy
        redirect_to admin_path, success: "Тема удалена"
    end

    private

    def theme_params
        params.require(:theme).permit(:title)
    end
  
    def set_theme
        @theme = Theme.find(params[:id]) rescue not_found
    end

    def model_name
        @model_one = Theme.model_name.human
        @model_many = Theme.model_name.human(count: :many)
    end

end
