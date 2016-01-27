class InverseFellowship < ActiveRecord::Base
  belongs_to :fellowships, dependent: :destroy
  belongs_to :user
  belongs_to :follower, class_name: 'User'
  validate :user_not_following_self
  validate :user_not_already_following
  
  private
  def user_not_following_self
    if user_id == follower_id
      errors.add(:user, 'User cannot be followed by themselves')
    end
  end
  
  def user_not_already_following
    if InverseFellowship.where(user_id: user_id, follower_id: follower_id).count > 0
      errors.add(:follower, 'User is already following this user')
    end
  end
end
