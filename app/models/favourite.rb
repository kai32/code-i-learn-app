class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  validates :user, presence: true
  validates :article, presence: true
end
