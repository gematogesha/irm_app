class SlidersController < ApplicationController

    before_action :loggedin, only: %i[create new update delete edit destroy]
    before_action :model_name
    before_action :set_slider, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        add_breadcrumb(@model_many)
        @page_title_text = @model_many

        if session[:admin]
            redirect_to admin_path
        end

    end

    def get_sliders
        @sliders = Slider.all.order(created_at: :desc)    
        add_breadcrumb(@model_many)
        @page_title_text = @model_many
    end

    def show
        add_breadcrumb(@model_many, sliders_url(subdomain: false))
        @slider.update_attribute(:views, @slider.views +=1 )
        @page_title_text = @slider.title
        @page_title_status = false

    end

    def create
        if !session[:admin]
            add_breadcrumb(@model_many, sliders_path)
        end
        @page_title_text = "Создать слайдер"
        @slider = Slider.create(slider_params)
        if @slider.save
          redirect_to admin_path, success: "Слайдер создан"
        else     
            render :new
        end
    end

    def new
        @slider = Slider.new
        if !session[:admin]
            add_breadcrumb(@model_many, sliders_path)
        end
        add_breadcrumb("Создать слайдер")
        @page_title_text = "Создать слайдер"
    end

    def edit
        if !session[:admin]
            add_breadcrumb(@model_many, sliders_path)
        end
        add_breadcrumb("Редактировать слайдер")
        @page_title_text = "Редактировать слайдер"  
    end


    def update      
        if !session[:admin]
            add_breadcrumb(@model_many, sliders_path)
        end
        @page_title_text = "Редактировать слайдер" 
        add_breadcrumb("Редактировать слайдер") 
        @slider.update(slider_params)
        if @slider.update(slider_params)
            redirect_to admin_path, success: "Слайдер обновлен"
        else 
            render :edit
        end
    end

    def destroy 
        @slider.destroy
        redirect_to admin_path, success: "Слайдер удален"
    end
    

    private

    def slider_params
        params.require(:slider).permit(:title, :description, :link, :image)
    end
  
    def set_slider
        @slider = Slider.find(params[:id]) rescue not_found
    end

    def model_name
        @model_one = Slider.model_name.human
        @model_many = Slider.model_name.human(count: :many)
    end

end
