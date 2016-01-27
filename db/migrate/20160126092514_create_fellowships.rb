class CreateFellowships < ActiveRecord::Migration
  def change
    create_table :fellowships do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :followee, class: 'User', index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
