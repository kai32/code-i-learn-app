class Fellowship < ActiveRecord::Base
  has_one :inverse_fellowship, dependent: :destroy
  belongs_to :user
  belongs_to :followee, class_name: 'User'
  validate :user_not_following_self
  validate :user_not_already_following
  
  private
  def user_not_following_self
    if user_id == followee_id
      errors.add(:followee, 'User cannot follow themselves')
    end
  end
  
  def user_not_already_following
    if Fellowship.where(user_id: user_id, followee_id: followee_id).count > 0
      errors.add(:followee, 'User is already following this user')
    end
  end
end
