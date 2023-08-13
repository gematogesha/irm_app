class SciencesController < ApplicationController

    before_action :loggedin, only: %i[create new update edit destroy]
    before_action :model_name
    before_action :set_science, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        add_breadcrumb(@model_many)
        @page_title_text = @model_many

        if session[:admin]
            redirect_to admin_path
        end

    end

    def show
        @sciences = Science.all
        @page_title_text = @science.title
        @page_title_status = true
        add_breadcrumb(@model_many)
    end

    def create
        add_breadcrumb("Создать науку")
        @page_title_text = "Создать науку"
        @science = Science.create(science_params)
        if @science.save
            redirect_to admin_path, success: "Наука создана"
        else     
            render :new
        end
    end

    def new
        @science = Science.new
        add_breadcrumb("Создать науку")
        @page_title_text = "Создать науку"

    end

    def edit
        add_breadcrumb("Редактировать науку")
        @page_title_text = "Редактировать науку"  
    end


    def update
        add_breadcrumb("Редактировать науку")
        @page_title_text = "Редактировать науку"  
        @science.update(science_params)
        if @science.update(science_params)
            redirect_to admin_path, success: "Наука обновлена"
        else 
            render :edit
        end
    end

    def destroy 
        @science.destroy
        redirect_to admin_path, success: "Наука удалена"
    end

    private

    def science_params
        params.require(:science).permit(:title, :content, :icon)
    end
  
    def set_science
        @science = Science.find_by!(page_title: params[:page_title]) rescue not_found
    end

    def model_name
        @model_one = Science.model_name.human
        @model_many = Science.model_name.human(count: :many)
    end

end
