class Article < ApplicationRecord
  validates_presence_of :title, :lead, :content, :category
  enum category: [:culture, :economy, :international, :lifestyle, :local, :sports]
end
