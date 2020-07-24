class Article < ApplicationRecord
  validates_presence_of :title, :lead, :content
end
