class New < ApplicationRecord

    has_rich_text :body

    before_create { self.number = "@" + SecureRandom.hex(3) }

end
