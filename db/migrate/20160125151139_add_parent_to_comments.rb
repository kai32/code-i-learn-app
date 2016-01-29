class AddParentToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :parent, references: :comments
  end
end
