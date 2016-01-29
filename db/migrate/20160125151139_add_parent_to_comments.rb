class AddParentToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :parent, class: 'Comment', index: true, foreign_key: true
  end
end
