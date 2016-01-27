class CreateUserCategories < ActiveRecord::Migration
  def change
    create_table :user_categories do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
