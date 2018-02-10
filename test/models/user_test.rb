require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "Example", email: "example@gmail.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be valid" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be valid" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "user name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "user email should not be too long" do
    @user.email = "a" * 254 + "@example.com"
    assert_not @user.valid?
  end

  test "user email should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} is a valid address"
    end
  end

  test "user should reject non-valid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                         foo@bar_baz.com foo@bar+baz.com foo@bar..com]
     invalid_addresses.each do |invalid_address|
     @user.email = invalid_address
     assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
   end
  end

  test "user should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    puts "duplicate user email = #{duplicate_user.email}"
    puts "user email  = #{@user.email}"
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
   mixed_case_email = "Foo@ExAMPle.CoM"
   @user.email = mixed_case_email
   @user.save
   assert_equal mixed_case_email.downcase, @user.reload.email
 end

 test "user password should be non-blank" do
   @user.password = @user.password_confirmation = " " * 6
   assert_not @user.valid?
 end

 test "user password length should be greater 5" do
   @user.password = @user.password_confirmation = "a" * 5
   assert_not @user.valid?
 end
end
