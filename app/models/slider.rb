class Slider < ApplicationRecord

    has_one_attached :image, dependent: :destroy

    validates :title, :description, presence: true

end
