class PostsController < ApplicationController

    before_action :loggedin, only: [:create, :new, :update, :delete]
    before_action :model_name
    before_action :set_post, only: %i[update show destroy edit]

    add_flash_types :info, :error, :success


    def index
        add_breadcrumb(@model_many)

        @page_title_text = @model_many
    end

    def get_posts
        @posts = Post.all.order(created_at: :desc)    
        
        add_breadcrumb(@model_many)

        @page_title_text = @model_many
    end

    def show

        @post.update_attribute(:views, @post.views +=1 )

        @page_title_text = @post.title
        
        @page_title_status = false

        add_breadcrumb(@model_many, posts_path)
    end

    def create
        add_breadcrumb(@model_many, posts_path)

        @page_title_text = "Создать новость"

        @post = Post.create(post_params)

        if @post.save
          redirect_to posts_path, success: "Новость создана"
        else     
            render :new
        end
    end

    def new
        @post = Post.new

        add_breadcrumb(@model_many, posts_path)

        @page_title_text = "Создать новость"

    end

    def edit
        add_breadcrumb(@model_many, posts_path)

        @page_title_text = "Редактировать новость"  
    end


    def update
        add_breadcrumb(@model_many, posts_path)

        @page_title_text = "Редактировать новость"  

        @post.update(post_params)
        
        if @post.update(post_params)
            redirect_to post_path(@post.number), success: "Новость обновлена"
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
