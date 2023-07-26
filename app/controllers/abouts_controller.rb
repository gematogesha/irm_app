class AboutsController < ApplicationController

    before_action :loggedin, only: %i[create new update delete edit destroy]
    before_action :model_name
    before_action :set_about, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        add_breadcrumb(@model_many)
        @page_title_text = @model_many
    end

    def show
        @page_title_text = @about.title
        
        @page_title_status = false

        add_breadcrumb(@model_many, abouts_url(subdomain: false))
    end

    def create
        add_breadcrumb(@model_many, abouts_path)
        @page_title_text = "Создать новость"
        @about = About.create(about_params)
        if @about.save
          redirect_to abouts_path, success: "Новость создана"
        else     
            render :new
        end
    end

    def new
        @about = About.new
        add_breadcrumb(@model_many, abouts_path)
        @page_title_text = "Создать новость"

    end

    def edit
        add_breadcrumb(@model_many, abouts_path)
        @page_title_text = "Редактировать новость"  
    end


    def update
        add_breadcrumb(@model_many, abouts_path)
        @page_title_text = "Редактировать новость"  
        @about.update(about_params)
        if @about.update(about_params)
            redirect_to about_path(@about.page_title), success: "Новость обновлена"
        else 
            render :edit
        end
    end

    private

    def about_params
        params.require(:about).permit(:title, :content, :page_title)
    end
  
    def set_about
        @about = About.find_by!(page_title: params[:page_title]) rescue not_found
    end

    def model_name
        @model_one = About.model_name.human
        @model_many = About.model_name.human(count: :many)
    end

end
