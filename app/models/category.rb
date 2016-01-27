class Category < ActiveRecord::Base
  has_many :article_categories, dependent: :destroy
  has_many :articles, through: :article_categories
  has_many :user_categories, dependent: :destroy
  has_many :users, through: :user_categories
end
