class HeadersController < ApplicationController

    before_action :loggedin, only: %i[create new update edit destroy]
    before_action :model_name
    before_action :set_header, only: %i[update show destroy edit]
    before_action :redirect, only: %i[show index]

    add_flash_types :info, :error, :success

    def create
        add_breadcrumb("Создать колонтитул")
        @page_title_text = "Создать колонтитул"
        @header = Header.create(header_params)
        if @header.save
          redirect_to admin_path, success: "Колонтитул создан"
        else     
            render :new
        end
    end

    def new
        @header = Header.new
        add_breadcrumb("Создать колонтитул")
        @page_title_text = "Создать колонтитул"
    end

    def edit
        add_breadcrumb("Редактировать колонтитул")
        @page_title_text = "Редактировать колонтитул"  
    end


    def update      
        @page_title_text = "Редактировать колонтитул" 
        add_breadcrumb("Редактировать колонтитул") 
        @header.update(header_params)
        if @header.update(header_params)
            redirect_to admin_path, success: "Колонтитул обновлен"
        else 
            render :edit
        end
    end

    def destroy 
        @header.destroy
        redirect_to admin_path, success: "Колонтитул удален"
    end
    
    private

    def header_params
        params.require(:header).permit(:title, :link, :image)
    end
  
    def set_header
        @header = Header.find(params[:id]) rescue not_found
    end

    def model_name
        @model_one = Header.model_name.human
        @model_many = Header.model_name.human(count: :many)
    end

    def redirect
        redirect_to admin_path
    end

end
