class Slider < ApplicationRecord

    has_one_attached :image, dependent: :destroy

    validates :title, :description, :link, :image, presence: true

end
