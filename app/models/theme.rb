class Theme < ApplicationRecord

    before_save :strip_ize

    def strip_ize
        title.strip!
    end

end
