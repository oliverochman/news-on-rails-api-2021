class AddPublishedToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :published, :boolean
  end
end
