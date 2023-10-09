class ProductsController < ApplicationController

    before_action :loggedin, only: %i[create new update edit destroy]
    before_action :model_name
    before_action :set_product, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        add_breadcrumb(@model_many)
        @page_title_text = @model_many

        redirect_to product_path(Product.first.page_title)

        if session[:admin]
            redirect_to admin_path
        end

    end

    def show
        @products = Product.all
        @page_title_text = @product.title
        @page_title_status = true
        add_breadcrumb(@model_many)
    end

    def create
        add_breadcrumb("Создать продукцию")
        @page_title_text = "Создать продукцию"
        @product = Product.create(product_params)
        if @product.save
            redirect_to admin_path, success: "Проудкция создана"
        else     
            render :new
        end
    end

    def new
        @product = Product.new
        add_breadcrumb("Создать продукцию")
        @page_title_text = "Создать продукцию"

    end

    def edit
        add_breadcrumb("Редактировать продукцию")
        @page_title_text = "Редактировать продукцию"  
    end


    def update
        add_breadcrumb("Редактировать продукцию")
        @page_title_text = "Редактировать продукцию"  
        @product.update(product_params)
        if @product.update(product_params)
            redirect_to admin_path, success: "Проудкция обновлена"
        else 
            render :edit
        end
    end

    def destroy 
        @product.destroy
        redirect_to admin_path, success: "Проудкция удалена"
    end

    private

    def product_params
        params.require(:product).permit(:title, :content, :icon)
    end
  
    def set_product
        @product = Product.find_by!(page_title: params[:page_title]) rescue not_found
    end

    def model_name
        @model_one = Product.model_name.human
        @model_many = Product.model_name.human(count: :many)
    end


end
