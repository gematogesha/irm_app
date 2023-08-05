class Header < ApplicationRecord

    validates :title, :link, presence: true

    before_save :strip_ize

    def strip_ize
        title.strip!
    end

end
