class Article < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, length: {minimum: 5, maxiumum: 30}
  validates :content, presence: true, length: {minimum: 10}
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  has_many :comments, dependent: :destroy
  ratyrate_rateable 'quality'
  
  def is_featured?
    is_featured
  end
end
