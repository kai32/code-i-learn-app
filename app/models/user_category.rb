class UserCategory < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validate :not_already_following
  
  def not_already_following
    if UserCategory.where(user_id: user_id, category_id: category_id).count > 0
      errors.add(:category, "already being followed")
    end
  end
end
