class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
  scope :friends, -> { where("status = 'accepted'", true) }
  scope :not_friends, -> { where("status = 'accepted'", false) }

  attribute :status, :string, default: 'requested'

  after_create :create_inverse
  validates_presence_of :user_id, :friend_id, :status
  validate :user_is_not_equal_friend
  validates_uniqueness_of :user_id, scope: :friend_id
  after_destroy :destroy_inverse

  def accept_request
    self.update_attribute(:status, 'accepted')
  end

  private

    def create_inverse
      self.class.create(user_id: self.friend.id, friend_id: self.user.id, status: 'pending')      
    end

    def destroy_inverse
      self.class.delete_by(user_id: self.friend.id, friend_id: self.user.id)
    end

    def user_is_not_equal_friend
      errors.add(:friend, "can't be the same as the user") if user == friend
    end
end
