class AddJournalistToArticles < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :journalist, foreign_key: {to_table: :users}
  end
end