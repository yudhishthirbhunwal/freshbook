class Comment < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  has_many :likes, dependent: :destroy
end
