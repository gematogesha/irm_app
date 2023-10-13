class Science < ApplicationRecord

    has_rich_text :content

    validates :title, :content, presence: true

    before_save :strip_ize

    before_create { self.page_title = self.title.to_lat.parameterize  }

    before_save { self.page_title = self.title.to_lat.parameterize  }
  
    def strip_ize
        title.strip!
    end


end
