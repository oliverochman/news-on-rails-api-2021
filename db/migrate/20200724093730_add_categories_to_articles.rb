class AddCategoriesToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :category, :integer
  end
end
