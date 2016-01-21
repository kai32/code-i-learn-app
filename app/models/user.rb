class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :last_name, presence: true
  
  def full_name
    name = "#{first_name} #{last_name}".strip
    if name.blank?
      name = "Annoymous"
    end
    name
  end
end
