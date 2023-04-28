class PostsController < ApplicationController

    before_action :model_name
    before_action :set_post, only: %i[update show destroy edit]


    add_flash_types :info, :error, :success


    def index
        @posts = Post.all.order(created_at: :desc)     
        
        add_breadcrumb("Новости")
        @page_title_text = @model_many
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

    def update
      @post.update(post_params)
      
      if @post.update(post_params)
        redirect_to posts_path, success: "Новость обновлена"
      else
        flash.now[:error] = "Неправильно заполнены формы"
  
        render :edit
      end
    end


    def new
        @post = Post.new

        add_breadcrumb("Новости", posts_path)

        @page_title_text = "Создать новость"

    end

    def edit
      @page_title_text = "Редактировать новость"      
    end

    def show
      @page_title_text = @post.title
      
      add_breadcrumb("Новости", posts_path)

      @blob = ActiveStorage::Attachment.find_by(record_id: @post.id)
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
