class AddIsFeaturedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_featured, :boolean, default: false
  end
end
