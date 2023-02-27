class NewsController < ApplicationController

    def index
    end



    private

    def news_params
      params.require(:news).permit(:title, :description, :reg_number, :issued, :series, :content, :begin, :ending, :user_id, :remark, :status, :file_news)
    end
  
    def set_news
      @news = News.find(params[:id]) rescue not_found
    end

end
