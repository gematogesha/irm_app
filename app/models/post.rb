class Post < ApplicationRecord

  has_rich_text :content

  has_one_attached :image, dependent: :destroy

  validates :title, :subtitle, :content, presence: true

  before_create { self.number = "@" + SecureRandom.hex(3) }

  before_save :strip_ize

  def strip_ize
      title.strip!
  end

  def next
    self.class.where("id > ?", id).first
  end

  def previous
    self.class.where("id < ?", id).last
  end


end
