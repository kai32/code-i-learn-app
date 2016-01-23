class Article < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, length: {minimum: 5, maxiumum: 30}
  validates :content, presence: true, length: {minimum: 10}
  
  def is_featured?
    is_featured
  end
end
