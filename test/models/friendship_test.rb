require "test_helper"

class FriendshipTest < ActiveSupport::TestCase

  def setup
    @friendship = Friendship.new(user_id: users(:admin).id,
    friend_id: users(:two).id)
  end

  test "should be valid" do
    assert @friendship.valid?
  end

  test "should require a user_id" do
    @friendship.user_id = nil
    assert_not @friendship.valid?
  end

  test "should require a friend_id" do
    @friendship.friend_id = nil
    assert_not @friendship.valid?
  end
end
