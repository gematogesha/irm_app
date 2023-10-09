class AboutsController < ApplicationController

    before_action :loggedin, only: %i[create new update edit destroy]
    before_action :model_name
    before_action :set_about, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        add_breadcrumb(@model_many)
        @page_title_text = @model_many
        redirect_to about_path(About.first.page_title)

        if session[:admin]
            redirect_to admin_path
        end

    end

    def show
        @abouts = About.all
        @page_title_text = @about.title
        @page_title_status = true
        add_breadcrumb(@model_many)
    end

    def create
        add_breadcrumb("Создать элемент")
        @page_title_text = "Создать элемент"
        @about = About.create(about_params)
        if @about.save
            redirect_to admin_path, success: "Элемент создан"
        else     
            render :new
        end
    end

    def new
        @about = About.new
        add_breadcrumb("Создать элемент")
        @page_title_text = "Создать элемент"

    end

    def edit
        add_breadcrumb("Редактировать элемент")
        @page_title_text = "Редактировать элемент"  
    end


    def update
        add_breadcrumb("Редактировать элемент")
        @page_title_text = "Редактировать элемент"  
        @about.update(about_params)
        if @about.update(about_params)
            redirect_to admin_path, success: "Элемент обновлен"
        else 
            render :edit
        end
    end

    def destroy 
        @about.destroy
        redirect_to admin_path, success: "Элемент удален"
    end

    private

    def about_params
        params.require(:about).permit(:title, :content, :icon)
    end
  
    def set_about
        @about = About.find_by!(page_title: params[:page_title]) rescue not_found
    end

    def model_name
        @model_one = About.model_name.human
        @model_many = About.model_name.human(count: :many)
    end

end
