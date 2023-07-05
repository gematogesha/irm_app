class Document < ApplicationRecord

    has_one_attached :file, dependent: :destroy

    validates :title, :file, presence: true
    
    before_save :strip_ize
    
    before_create { self.page_title = self.title.to_lat.parameterize  }

    before_save { self.page_title = self.title.to_lat.parameterize  }
  
    def strip_ize
        title.strip!
    end
    
end
