class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  belongs_to :parents, class_name: "Comment"
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  validates :article, presence: true
  validates :user, presence: true
  validates :content, presence: true, length: { minimum: 10, maximum: 300 }
end
