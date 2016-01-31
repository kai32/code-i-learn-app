class Article < ActiveRecord::Base
  attr_accessor :draft_id
  include Bootsy::Container
  belongs_to :user
  validates :title, presence: true, length: {minimum: 5, maxiumum: 30}
  validates :content, presence: true, length: {minimum: 10}
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  has_many :comments, dependent: :destroy
  validates :description, presence: true, length: {maximum: 140}
  ratyrate_rateable 'quality'
  has_many :favourites, dependent: :destroy
  has_many :fans, source: :user, through: :favourites, foreign_key: :user_id
  after_save :destroy_draft
  
  def save_as_draft
    return false unless new_record?
    if !draft_id
      draft = Draft.new(title: title, content: content, user_id: user_id, description: description)
      draft.save
    else
      draft = Draft.find(draft_id).update(title: title, content: content, user_id: user_id, description: description)
    end
    
    # problem, doesnt assign current object with id of saved draft
  end
  
  def self.from_draft(draft)
    draft.create_article
  end
  
  def self.find_draft(draft_id)
    Draft.find(draft_id)
  end
  
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
  
  def related_articles(limit = nil)
    categories_id_text = "("
    size = categories.size
    if size > 0
      categories.each_with_index do |category, i|
        categories_id_text += "#{category.id.to_s}"
        if i < size - 1
          categories_id_text += ", "
        end
      end
      categories_id_text += ")"
    else
      categories_id_text += "0)"
    end
    Article.find_by_sql("select id, title, is_featured FROM" +
    " (articles LEFT JOIN (select article_id, COUNT(article_id) AS number_of_matches " +
    " FROM article_categories where category_id IN #{categories_id_text} " + 
    " GROUP BY article_id) AS subquery ON articles.id = article_id) " +
    " ORDER BY number_of_matches desc, is_featured desc" +
    ( limit ? " LIMIT #{limit + 1}" : "")) - [self] # limit + 1 cus deducting self
  end
  
  class Draft < ActiveRecord::Base
    belongs_to :user
    
    def create_article 
      article = Article.new(title: title, content: content, user_id: user_id, description: description, draft_id: id)
    end
  end
  
  
  def destroy_draft
    if draft_id
      Draft.find(draft_id).destroy
    end
  end
  
end
