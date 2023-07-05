class SlidersController < ApplicationController

    before_action :loggedin
    before_action :model_name
    before_action :set_slider, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        @sliders = Slider.all  
    end


    def create
        add_breadcrumb(@model_many, sliders_path)

        @page_title_text = "Создать слайдер"

        @slider = Slider.create(slider_params)

        if @slider.save
          redirect_to root_path, success: "Слайдер создан"
        else     
            render :new
        end
    end
    

    def new
        @slider = Slider.new

        add_breadcrumb(@model_many, sliders_path)

        @page_title_text = "Создать слайдер"

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
