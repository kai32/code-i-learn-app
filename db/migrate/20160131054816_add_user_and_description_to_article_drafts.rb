class AddUserAndDescriptionToArticleDrafts < ActiveRecord::Migration
  def change
    add_reference :article_drafts, :user, index: true, foreign_key: true
    add_column :article_drafts, :description, :text
  end
end
