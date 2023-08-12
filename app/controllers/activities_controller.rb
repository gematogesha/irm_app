class ActivitiesController < ApplicationController

    before_action :loggedin, only: %i[create new update edit destroy]
    before_action :model_name
    before_action :set_activity, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def show
        @activities = Activity.all
        @page_title_text = @activity.title
        @page_title_status = true
        add_breadcrumb(@model_many)
    end

    def create
        add_breadcrumb("Создать элемент")
        @page_title_text = "Создать элемент"
        @activity = Activity.create(activity_params)
        if @activity.save
            redirect_to activities_path, success: "Элемент создан"
        else     
            render :new
        end
    end

    def new
        @activity = Activity.new
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
        @activity.update(activity_params)
        if @activity.update(activity_params)
            redirect_to admin_path, success: "Элемент обновлен"
        else 
            render :edit
        end
    end

    def destroy 
        @activity.destroy
        redirect_to admin_path, success: "Документ удален"
    end

    private

    def activity_params
        params.require(:activity).permit(:title, :subtitle, :image, :content, :icon)
    end
  
    def set_activity
        @activity = Activity.find_by!(page_title: params[:page_title]) rescue not_found
    end

    def model_name
        @model_one = Activity.model_name.human
        @model_many = Activity.model_name.human(count: :many)
    end

end
