class NewsController < ApplicationController

    add_flash_types :info, :error, :success

    def index
      @news = News.all
    end

    def show

    end

    def create
      @news = News.create(news_params)
      if @news.save
        redirect_to news_index_path, success: "Новость создана"
      else
        flash.now[:error] = "Что-то пошло не так..."
  
        redirect_to @news
      end
    end

    def new
      @news = News.new
    end 


    private

    def news_params
      params.require(:news).permit(:title, :body)
    end
  
    def set_news
      @news = News.find(params[:id]) rescue not_found
    end

end
