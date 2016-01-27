class AddFellowshipToInverseFellowships < ActiveRecord::Migration
  def change
    add_reference :inverse_fellowships, :fellowship, index: true, foreign_key: true
  end
end
