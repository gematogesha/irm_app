class ActivitiesController < ApplicationController

    before_action :loggedin, only: %i[create new update edit destroy]
    before_action :model_name
    before_action :set_activity, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success

    def index
        redirect_to activity_path(Activity.first.page_title)
    end


    def show
        @activities = Activity.all
        @page_title_text = @activity.title
        @page_title_status = true
        add_breadcrumb(@model_many)
    end

    def create
        add_breadcrumb("Создать деятельность")
        @page_title_text = "Создать деятельность"
        @activity = Activity.create(activity_params)
        if @activity.save
            redirect_to admin_path, success: "Деятельность создан"
        else     
            render :new
        end
    end

    def new
        @activity = Activity.new
        add_breadcrumb("Создать деятельность")
        @page_title_text = "Создать деятельность"
    end

    def edit
        add_breadcrumb("Редактировать деятельность")
        @page_title_text = "Редактировать деятельность"  
    end

    def update
        add_breadcrumb("Редактировать деятельность")
        @page_title_text = "Редактировать деятельность"  
        @activity.update(activity_params)
        if @activity.update(activity_params)
            redirect_to admin_path, success: "Деятельность обновлен"
        else 
            render :edit
        end
    end

    def destroy 
        @activity.destroy
        redirect_to admin_path, success: "Деятельность удалена"
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
