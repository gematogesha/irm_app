class PostsController < ApplicationController

    before_action :model_name
    before_action :set_post, only: %i[update show destroy edit]
  
    add_flash_types :info, :error, :success


    def index
        @posts = Post.all        
    end

    def create
        @post = Post.create(post_params)
    
        if @post.save
          redirect_to posts_path, success: "Новость создана"
        else
          flash.now[:error] = "Неправильно заполнены формы"
    
          render :new
        end
      end


    def new
        @post = Post.new
      end

    def show
        
    end


    private

    def post_params
      params.require(:post).permit(:title, :content)
    end
  
    def set_post
      @post = Post.find_by!(number: params[:number]) rescue not_found
    end

    def model_name
        @model_one = Post.model_name.human
        @model_many = Post.model_name.human(count: :many)
      end

end
