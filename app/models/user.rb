class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :last_name, presence: true
  
  has_many :articles, dependent: :destroy
  
  mount_uploader :avatar, AvatarUploader
  validate :avatar_size
  
  
  
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
  
  private
  
  def avatar_size
    if avatar.size > 3.megabytes
      errors.add(:avatar, "should be less than 3mb")
    end
  end
end
