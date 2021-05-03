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
    Micropost.where("user_id = ?", id)
  end
end
