class Comment < ApplicationRecord
  belongs_to :micropost
  belongs_to :user

  validates [:user_id, :micropost_id], presence: true
  validates :content, presence: true 
end
