class Banner < ApplicationRecord

    has_one_attached :image, dependent: :destroy

    validates :title, :description, :link, :image, presence: true

    before_save :strip_ize, :chomp

    def strip_ize
        title.strip!
    end

    def chomp
        self.link = self.link.chomp("/")
    end

end
