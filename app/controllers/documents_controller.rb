class DocumentsController < ApplicationController

    before_action :loggedin, only: %i[create new update edit destroy]
    before_action :model_name
    before_action :set_document, only: %i[update show destroy edit]
    before_action :set_themes, only: %i[update new create edit index]

    add_flash_types :info, :error, :success


    def index
        @documents = Document.all
        add_breadcrumb(@model_many)
        @page_title_text = @model_many
        if session[:admin]
            redirect_to admin_path
        end
    end

    def create
        add_breadcrumb("Создать документ")
        @page_title_text = "Создать документ"
        @document = Document.create(document_params)
        if @document.save
          redirect_to admin_path, success: "Документ создан"
        else     
            render :new
        end
    end

    def new
        @document = Document.new
        add_breadcrumb("Создать документ")
        @page_title_text = "Создать документ"

    end

    def show
        @page_title_text = @document.title
        add_breadcrumb(@model_many, documents_url(subdomain: false))
    end

    def edit
        add_breadcrumb("Редактировать документ")
        @page_title_text = "Редактировать документ"  
    end


    def update
        add_breadcrumb("Редактировать документ")
        @page_title_text = "Редактировать документ"  
        @document.update(document_params)
        if @document.update(document_params)
            redirect_to admin_path, success: "Документ обновлен"
        else 
            render :edit
        end
    end

    def destroy 
        @document.destroy
        redirect_to admin_path, success: "Документ удален"
    end

    private

    def document_params
        params.require(:document).permit(:title, :description, :theme_id, :file, :themes)
    end
  
    def set_document
        @document = Document.find_by!(page_title: params[:page_title]) rescue not_found
    end

    def model_name
        @model_one = Document.model_name.human
        @model_many = Document.model_name.human(count: :many)
    end

    def set_themes
        @themes = Theme.all
    end

end
