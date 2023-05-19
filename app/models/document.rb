class Document < ApplicationRecord

    has_one_attached :file, dependent: :destroy

    validates :title, presence: true
    
end
