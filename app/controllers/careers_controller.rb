class CareersController < ApplicationController

    before_action :loggedin, only: %i[create new update edit destroy]
    before_action :model_name
    before_action :set_career, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        add_breadcrumb(@model_many)
        @page_title_text = @model_many

        redirect_to career_path(Career.first.page_title)

        if session[:admin]
            redirect_to admin_path
        end

    end

    def show
        @careers = Career.all
        @page_title_text = @career.title
        @page_title_status = true
        add_breadcrumb(@model_many)
    end

    def create
        add_breadcrumb("Создать карьеру")
        @page_title_text = "Создать карьеру"
        @career = Career.create(career_params)
        if @career.save
            redirect_to admin_path, success: "Карьера создана"
        else     
            render :new
        end
    end

    def new
        @career = Career.new
        add_breadcrumb("Создать карьеру")
        @page_title_text = "Создать карьеру"

    end

    def edit
        add_breadcrumb("Редактировать карьеру")
        @page_title_text = "Редактировать карьеру"  
    end


    def update
        add_breadcrumb("Редактировать карьеру")
        @page_title_text = "Редактировать карьеру"  
        @career.update(career_params)
        if @career.update(career_params)
            redirect_to admin_path, success: "Карьера обновлена"
        else 
            render :edit
        end
    end

    def destroy 
        @career.destroy
        redirect_to admin_path, success: "Карьера удалена"
    end

    private

    def career_params
        params.require(:career).permit(:title, :content, :icon)
    end
  
    def set_career
        @career = Career.find_by!(page_title: params[:page_title]) rescue not_found
    end

    def model_name
        @model_one = Career.model_name.human
        @model_many = Career.model_name.human(count: :many)
    end

end
