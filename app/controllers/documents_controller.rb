class DocumentsController < ApplicationController

    before_action :loggedin, only: [:create, :new, :update, :delete]
    before_action :model_name
    before_action :set_document, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        @documents = Document.all

        add_breadcrumb(@model_many)

        @page_title_text = @model_many
    end

    def create
        add_breadcrumb(@model_many, documents_path)

        @page_title_text = "Создать документ"

        @document = Document.create(document_params)

        if @document.save
          redirect_to documents_path, success: "Документ создан"
        else     
            render :new
        end
    end

    def new
        @document = Document.new

        add_breadcrumb(@model_many, documents_path)

        @page_title_text = "Создать документ"

    end

    def show

        @page_title_text = @document.title
        
        add_breadcrumb(@model_many, documents_path)

    end

    def new
        @document = Document.new

        add_breadcrumb(@model_many, documents_path)

        @page_title_text = "Создать документ"

    end

    def edit
        add_breadcrumb(@model_many, documents_path)

        @page_title_text = "Редактировать документ"  
    end


    def update
        add_breadcrumb(@model_many, documents_path)

        @page_title_text = "Редактировать документ"  

        @document.update(document_params)
        
        if @document.update(document_params)
            redirect_to document_path(@document.page_title), success: "Документ обновлен"
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
