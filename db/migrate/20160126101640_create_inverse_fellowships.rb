class CreateInverseFellowships < ActiveRecord::Migration
  def change
    create_table :inverse_fellowships do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :follower, class: 'User', index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
