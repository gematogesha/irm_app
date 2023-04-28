class Post < ApplicationRecord

  has_rich_text :content

  before_create { self.number = "@" + SecureRandom.hex(3) }

  validates :title, :content, presence: true

  before_save :capitalize_title, :strip_ize

  def capitalize_title
      title.capitalize!
  end

  def strip_ize
      title.strip!
  end


end
