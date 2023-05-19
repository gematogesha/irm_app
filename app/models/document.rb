class Document < ApplicationRecord

    has_one_attached :file, dependent: :destroy

    validates :title, presence: true

    before_save :strip_ize

    def strip_ize
        title.strip!
    end
    
end
