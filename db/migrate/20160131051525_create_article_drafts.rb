class CreateArticleDrafts < ActiveRecord::Migration
  def change
    create_table :article_drafts do |t|
      t.string :title
      t.text :content
      t.timestamps null: false
    end
  end
end
