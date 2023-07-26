class PostsController < ApplicationController

    before_action :loggedin, only: [:create, :new, :update, :delete, :edit]
    before_action :model_name
    before_action :set_post, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        add_breadcrumb(@model_many)
        @page_title_text = @model_many

        if session[:admin]
            redirect_to admin_path
        end

    end

    def get_posts
        @posts = Post.all.order(created_at: :desc)    
        add_breadcrumb(@model_many)
        @page_title_text = @model_many
    end

    def show
        add_breadcrumb(@model_many, posts_url(subdomain: false))
        @post.update_attribute(:views, @post.views +=1 )
        @page_title_text = @post.title
        @page_title_status = false

    end

    def create
        if !session[:admin]
            add_breadcrumb(@model_many, posts_path)
        end
        @page_title_text = "Создать новость"
        @post = Post.create(post_params)
        if @post.save
          redirect_to admin_path, success: "Новость создана"
        else     
            render :new
        end
    end

    def new
        @post = Post.new
        if !session[:admin]
            add_breadcrumb(@model_many, posts_path)
        end
        add_breadcrumb("Создать новость")
        @page_title_text = "Создать новость"
    end

    def edit
        if !session[:admin]
            add_breadcrumb(@model_many, posts_path)
        end
        add_breadcrumb("Редактировать новость")
        @page_title_text = "Редактировать новость"  
    end


    def update      
        if !session[:admin]
            add_breadcrumb(@model_many, posts_path)
        end
        @page_title_text = "Редактировать новость" 
        add_breadcrumb("Редактировать новость") 
        @post.update(post_params)
        if @post.update(post_params)
            redirect_to admin_path, success: "Новость обновлена"
        else 
            render :edit
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :subtitle, :content, :image, :hot, :best)
    end
  
    def set_post
        @post = Post.find_by!(number: params[:number]) rescue not_found
    end

    def model_name
        @model_one = Post.model_name.human
        @model_many = Post.model_name.human(count: :many)
    end

end
