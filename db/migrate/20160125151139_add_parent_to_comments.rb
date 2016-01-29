class AddParentToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :parent, references: :comments, index: true, foreign_key: true
  end
end
