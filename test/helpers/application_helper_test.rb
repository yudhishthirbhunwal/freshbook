require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "full title helper" do
    assert_equal full_title, "FreshBook"
    assert_equal full_title("Help"), "Help | FreshBook"
  end

end