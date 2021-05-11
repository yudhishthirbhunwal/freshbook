class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  has_one_attached :image

  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }
  validates :content, presence: true, unless: Proc.new { |post| post.image.attached? }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: "must be a valid image format" },
                            size: { less_than: 5.megabytes,
                                    message: "should be less than 5MB" }

end
