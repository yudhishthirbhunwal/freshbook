class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where ("status = 'accepted'") }, through: :friendships
  has_many :pending_friends, -> { where ("status = 'pending'") }, through: :friendships, source: :friend
  has_many :requested_friends, -> { where ("status = 'requested'") }, through: :friendships, source: :friend
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable, :lockable

  # Defines a proto-feed.
  def feed
    Micropost.where("user_id IN (SELECT DISTINCT user_id FROM friendships
                                 WHERE status = 'accepted')
                                 OR user_id = ?", id)
  end

  # Checks if friendship exists with the current user.
  def is_friend?(user)
    friendship = Friendship.find_by(user_id: self.id, friend_id: user.id)
    friendship.present?
  end
end
