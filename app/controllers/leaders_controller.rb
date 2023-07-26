class LeadersController < ApplicationController

    def index
        add_breadcrumb('@model_many')
        @page_title_text = @model_many
    end

    def new
        
    end

end
