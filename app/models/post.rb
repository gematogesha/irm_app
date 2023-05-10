class Post < ApplicationRecord

  has_rich_text :content

  has_one_attached :image

  validates :title, :content, presence: true

  before_create { self.number = "@" + SecureRandom.hex(3) }

  before_save :strip_ize

  def strip_ize
      title.strip!
  end


end
