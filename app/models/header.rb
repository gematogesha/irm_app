class Header < ApplicationRecord

    validates :title, presence: true

    belongs_to :about

    before_save :strip_ize

    def strip_ize
        title.strip!
    end

end
