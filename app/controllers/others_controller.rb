class OthersController < ApplicationController

    before_action :loggedin, only: %i[create new update edit destroy]
    before_action :model_name
    before_action :set_other, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        @page_title_text = @model_many

        if session[:admin]
            redirect_to admin_path
        end

    end

    def show
        @others = Other.all
        @page_title_text = @other.title
        @page_title_status = false
        add_breadcrumb(@model_many)
    end

    def create
        add_breadcrumb("Создать элемент")
        @page_title_text = "Создать элемент"
        @other = Other.create(other_params)
        if @other.save
            redirect_to admin_path, success: "Элемент создан"
        else     
            render :new
        end
    end

    def new
        @other = Other.new
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
        @other.update(other_params)
        if @other.update(other_params)
            redirect_to admin_path, success: "Элемент обновлен"
        else 
            render :edit
        end
    end

    def destroy 
        @other.destroy
        redirect_to admin_path, success: "Элемент удален"
    end

    private

    def other_params
        params.require(:other).permit(:title, :content, :icon)
    end
  
    def set_other
        @other = Other.find_by!(page_title: params[:page_title]) rescue not_found
    end

    def model_name
        @model_one = Other.model_name.human
        @model_many = Other.model_name.human(count: :many)
    end

    
end
