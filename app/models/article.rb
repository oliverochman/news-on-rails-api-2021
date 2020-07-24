class Article < ApplicationRecord
  validates_presence_of :title, :lead, :content, :category
  enum category: [:sports, :economy, :lifestyle]
end
