class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :last_name, presence: true
  
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :fellowships, dependent: :destroy
  has_many :followees, through: :fellowships, foreign_key: :followee_id
  has_many :inverse_fellowships, dependent: :destroy
  has_many :followers, through: :inverse_fellowships, foreign_key: :follower_id
  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories
  
  mount_uploader :avatar, AvatarUploader
  validate :avatar_size
  
  ratyrate_rater
  
  
  def is_admin?
    is_admin
  end
  
  def full_name
    name = "#{first_name} #{last_name}".strip
    if name.blank?
      name = "Annoymous"
    end
    name
  end
  
  def is_following?(user)
    followees.where(id: user.id).count > 0
  end
  
  def is_following_category?(category)
    categories.where(id: category.id).count > 0
  end
  
  
  def follow_user(followee)
    #current user instance will follow user in the param
    return false unless followee
    Fellowship.transaction do
      InverseFellowship.transaction do
        fellowship = Fellowship.new(user_id: id, followee_id: followee.id)
        begin
          if fellowship.save
            inverse_fellowship = InverseFellowship.new(user_id: followee.id, follower_id: id, fellowship_id: fellowship.id)
            if inverse_fellowship.save
              return true
            else
              raise ActiveRecord::Rollback
            end
          else
            raise ActiveRecord::Rollback
          end
        rescue
          return false
        end
      end
    end
  end
  
  private
  
  def avatar_size
    if avatar.size > 3.megabytes
      errors.add(:avatar, "should be less than 3mb")
    end
  end
end
