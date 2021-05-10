require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new( firstname: "User", lastname: "Example",
                      phonenumber: "9876543210", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar" )    
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "first name should be present" do
    @user.firstname="  "
    assert_not @user.valid?
  end

  test "last name should be present" do
    @user.lastname="  "
    assert_not @user.valid?
  end

  test "phone number should be present" do
    @user.phonenumber="   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email="   "
    assert_not @user.valid?
  end

  test "first name should not be too long" do
    @user.firstname='a'*51
    assert_not @user.valid?
  end

  test "last name should not be too long" do
    @user.lastname='a'*51
    assert_not @user.valid?
  end

  test "phone number should be exactly 10 digits long" do
    @user.phonenumber='8'*5
    assert_not @user.valid?
    @user.phonenumber='9'*15
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email="a"*244+"@example.com"
    assert_not @user.valid?
  end

  test "phonenumber validation should accept valid phone numbers" do
    valid_numbers = %w[9876543210 8888888888 1412424957]
    valid_numbers.each do |valid_number|
      @user.phonenumber = valid_number
      assert @user.valid?, "#{valid_number.inspect} should be valid"
    end
  end

  test "phonenumber validation should reject invalid phone numbers" do
    invalid_numbers = %w[987654321 88888 01412424957 asdfghjkla w1w2w38989]
    invalid_numbers.each do |invalid_number|
      @user.phonenumber = invalid_number
      assert_not @user.valid?, "#{invalid_number.inspect} should be valid"
    end
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com USERfoo.COM A_US-ER@fo-o.bar.or-g
      first.last@foo_.jp alice+bob@baz..cn user_at_foo.org user.name@example. 
      foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

 test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = "      "
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a"*5
    assert_not @user.valid?
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should friend and unfriend a user" do
    adminUser = users(:admin)
    adminUser.confirm
    user = users(:two)
    user.confirm
    assert_not adminUser.friend_request_exists?(user)
    adminUser.send_request(user)
    assert adminUser.friend_request_exists?(user)
    user.accept_request(adminUser)
    assert adminUser.friends.include?(user)
    adminUser.unfriend(user)
    assert_not adminUser.friends.include?(user)
  end

  test "feed should have the right posts" do
    adminUser = users(:admin)
    adminUser.confirm
    friendUser = users(:one)
    friendUser.confirm
    otherUser = users(:two)
    otherUser.confirm
    # Posts from friend user
    friendUser.microposts.each do |post_friend|
      assert adminUser.feed.include?(post_friend)
    end
    # Posts from self
    adminUser.microposts.each do |post_self|
      assert adminUser.feed.include?(post_self)
    end
    # Posts from other user
    otherUser.microposts.each do |post_other|
      assert_not adminUser.feed.include?(post_other)
    end
  end
end
