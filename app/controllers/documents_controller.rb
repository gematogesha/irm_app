class DocumentsController < ApplicationController

    before_action :loggedin, only: [:create, :new, :update, :delete, :edit]
    before_action :model_name
    before_action :set_document, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        @documents = Document.all
        add_breadcrumb(@model_many)
        @page_title_text = @model_many
    end

    def create
        if !session[:admin]
            add_breadcrumb(@model_many, documents_path)
        end
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
        if !session[:admin]
            add_breadcrumb(@model_many, documents_path)
        end
        @document = Document.new
        add_breadcrumb("Создать документ")
        @page_title_text = "Создать документ"

    end

    def show
        @page_title_text = @document.title
        add_breadcrumb(@model_many, documents_url(subdomain: false))
    end

    def edit
        if !session[:admin]
            add_breadcrumb(@model_many, documents_path)
        end
        add_breadcrumb("Редактировать документ")
        @page_title_text = "Редактировать документ"  
    end


    def update
        if !session[:admin]
            add_breadcrumb(@model_many, documents_path)
        end
        add_breadcrumb("Редактировать документ")
        @page_title_text = "Редактировать документ"  
        @document.update(document_params)
        if @document.update(document_params)
            redirect_to admin_path, success: "Документ обновлен"
        else 
            render :edit
        end
    end

    private

    def document_params
        params.require(:document).permit(:title, :description, :file)
    end
  
    def set_document
        @document = Document.find_by!(page_title: params[:page_title]) rescue not_found
    end

    def model_name
        @model_one = Document.model_name.human
        @model_many = Document.model_name.human(count: :many)
    end

end
