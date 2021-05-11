class Comment < ApplicationRecord
  belongs_to :micropost
  belongs_to :user

  has_one_attached :image

  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :content, presence: true, unless: Proc.new { |comment| comment.image.attached? }
  validates :content, length: { maximum: 140 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: "must be a valid image format" },
                            size: { less_than: 5.megabytes,
                                    message: "should be less than 5MB" }
end
