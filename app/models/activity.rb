class Activity < ApplicationRecord

    has_rich_text :content

    has_one_attached :image, dependent: :destroy

    validates :title, :subtitle, :content, presence: true

    before_save :strip_ize

    before_create { self.page_title = self.title.to_lat.parameterize  }

    before_save { self.page_title = self.title.to_lat.parameterize  }
  
    def strip_ize
        title.strip!
    end


end
