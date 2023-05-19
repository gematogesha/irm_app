class DocumentsController < ApplicationController

    before_action :model_name
    before_action :set_document, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        @documents = Document.all
    end

    private

    def document_params
        params.require(:document).permit(:title, :content, :image, :hot, :best)
    end
  
    def set_document
        @document = Document.find_by!(number: params[:number]) rescue not_found
    end

    def model_name
        @model_one = Document.model_name.human
        @model_many = Document.model_name.human(count: :many)
    end

end
