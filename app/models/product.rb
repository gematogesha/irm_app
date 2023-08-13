class Product < ApplicationRecord

    has_rich_text :content

    has_one :header, dependent: :destroy

    validates :title, :content, presence: true

    before_save :strip_ize

    before_create { self.page_title = self.title.to_lat.parameterize  }

    before_save { self.page_title = self.title.to_lat.parameterize  }
  
    def strip_ize
        title.strip!
    end



end
