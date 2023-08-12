class LeadersController < ApplicationController

    before_action :loggedin, only: %i[create new update delete edit destroy]
    before_action :model_name
    before_action :set_leader, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        @leaders = Leader.all
        add_breadcrumb(@model_many)
        @page_title_text = @model_many
        @abouts = About.all
        
        if session[:admin]
            redirect_to admin_path
        end

    end

    def create
        add_breadcrumb("Создать руководителя")
        @page_title_text = "Создать руководителя"
        @leader = Leader.create(leader_params)
        if @leader.save
          redirect_to admin_path, success: "Руководитель создан"
        else     
            render :new
        end
    end

    def new
        @leader = Leader.new
        add_breadcrumb("Создать руководителя")
        @page_title_text = "Создать руководителя"
    end

    def edit
        add_breadcrumb("Редактировать руководителя")
        @page_title_text = "Редактировать руководителя"  
    end


    def update      
        @page_title_text = "Редактировать руководителя" 
        add_breadcrumb("Редактировать руководителя") 
        @leader.update(leader_params)
        if @leader.update(leader_params)
            redirect_to admin_path, success: "Руководитель обновлен"
        else 
            render :edit
        end
    end

    def destroy 
        @leader.destroy
        redirect_to admin_path, success: "Руководитель удалена"
    end
    

    private

    def leader_params
        params.require(:leader).permit(:name, :post, :image)
    end
  
    def set_leader
        @leader = Leader.find_by!(page_title: params[:page_title]) rescue not_found
    end

    def model_name
        @model_one = Leader.model_name.human
        @model_many = Leader.model_name.human(count: :many)
    end

end
