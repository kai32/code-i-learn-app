class Article < ActiveRecord::Base
  include Bootsy::Container
  belongs_to :user
  validates :title, presence: true, length: {minimum: 5, maxiumum: 30}
  validates :content, presence: true, length: {minimum: 10}
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  has_many :comments, dependent: :destroy
  validates :description, presence: true, length: {maximum: 140}
  ratyrate_rateable 'quality'
  
  def is_featured?
    is_featured
  end
  
  def self.followed_by(user)
    followee_array = []
    user.followees.each do |followee|
      followee_array.push(followee.id)
    end
    user_categories_array = []
    user.categories.each do |category|
      user_categories_array.push(category.id)
    end
    Article
    .joins("LEFT OUTER JOIN article_categories ON articles.id =  article_categories.article_id " + 
            "LEFT OUTER JOIN categories ON categories.id = article_categories.category_id")
    .where('(categories.id IN (?) or user_id IN (?)) and user_id != ?', 
            user_categories_array, followee_array, user.id) 
    .order(created_at: :desc)
    
  end
end
