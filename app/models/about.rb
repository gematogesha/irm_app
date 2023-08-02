class About < ApplicationRecord

    has_rich_text :content

    validates :title, :content, presence: true

    before_save :strip_ize

    def strip_ize
        title.strip!
    end

end
