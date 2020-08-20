class Article < ApplicationRecord
  validates_presence_of :title, :lead, :content, :category
  enum category: [:culture, :economy, :international, :lifestyle, :sports]
  belongs_to :journalist, class_name: "User"

  has_one_attached :image

end