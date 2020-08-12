class Article < ApplicationRecord
  validates_presence_of :title, :lead, :content, :category
  enum category: [:culture, :economy, :international, :lifestyle, :local, :sports]
  belongs_to :journalist, class_name: "User"

end