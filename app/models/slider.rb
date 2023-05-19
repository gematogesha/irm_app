class Slider < ApplicationRecord

    has_one_attached :image, dependent: :destroy

    validates :title, :description, :link, :image, presence: true

    before_save :strip_ize

    def strip_ize
        title.strip!
    end


end
