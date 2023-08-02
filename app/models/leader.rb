class Leader < ApplicationRecord

    has_one_attached :image, dependent: :destroy

    validates :name, :post, :image, presence: true
    
    before_save :strip_ize
    
    before_create { self.page_title = self.name.to_lat.parameterize  }

    before_save { self.page_title = self.name.to_lat.parameterize  }
  
    def strip_ize
        name.strip!
    end
    

end
