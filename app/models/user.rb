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

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\d{10}/
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :lastname, presence: true, length: { maximum: 50 }
  validates :phonenumber, presence: true, length: { minimum: 10, maximum: 10}, format: { with: VALID_PHONE_REGEX }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  # Defines a feed.
  def feed
    Micropost.where(user_id: self.friends).or(Micropost.where(user_id: self))
  end

  # Checks if a request has been sent.
  def friend_request_exists?(user)
    friendship = Friendship.find_by(user_id: self.id, friend_id: user.id)
    friendship.present?
  end

  # Checks if a user is friends with current user.
  def is_friend?(user)
    self.friends.include?(user)
  end

  # Sends a request to a user.
  def send_request(user)
    self.requested_friends << user
  end

  # Accepts a request from a user.
  def accept_request(user)
    friendship = Friendship.find_by(user_id: self.id, friend_id: user.id)
    friendship_rev = Friendship.find_by(user_id: user.id, friend_id: self.id)
    friendship.update_attribute(:status, 'accepted')
    friendship_rev.update_attribute(:status, 'accepted')
  end

  # Unfriends a user.
  def unfriend(user)
    friendship = Friendship.find_by(user_id: self.id, friend_id: user.id)
    friendship.delete
  end

  # Searchs a particular user.
  def self.search(search)
    if search
      self.where("LOWER(firstname) LIKE (?) OR LOWER(lastname) LIKE (?)", search.downcase, search.downcase)
    end    
  end

end
