class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  validates :article, presence: true
  validates :user, presence: true
  validates :content, presence: true, length: { minimum: 10, maximum: 300 }
end
