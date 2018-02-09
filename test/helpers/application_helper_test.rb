require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  @base_title = " | Ruby on Rails Sample Tutorial"
  test "full title helper" do
    assert_equal full_title("Home"), "Home | Ruby on Rails Sample Tutorial"
    assert_equal full_title("Help"), "Help | Ruby on Rails Sample Tutorial"
    assert_equal full_title("Contact"), "Contact | Ruby on Rails Sample Tutorial"
    assert_equal full_title("About"), "About | Ruby on Rails Sample Tutorial"
  end
end
