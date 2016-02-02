require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save user without params" do
    user = User.new
    assert_not user.save, "Saved the user without params"
  end
  
  test "should not save user without email" do
    user = User.new(:password => "abcdef", :password_confirmation => "abcdef")
    assert_not user.save, "Saved the user without an email address"
  end
  
  test "should not save user without password" do
    user = User.new(:email => "hello@example.com")
    assert_not user.save, "Saved the user without a password"
  end
  
  test "should not save user without strong password" do
    user = User.new(:email => "hello@example.com", :password => "1234")
    assert_not user.save, "Saved the user without a strong password"
  end
  
  test "should save the user with email and strong password" do
    user = User.new(:email => "hello@example.com", :password => "12345")
    assert user.save, "Saved the user without a strong password"
  end
  
  test "should not save the user already used email" do
    user_1 = User.new(:email => "hello@example.com", :password => "12345")
    assert user_1.save, "Saved the user without a strong password"
    user_2 = User.new(:email => "hello@example.com", :password => "12345")
    assert_not user_2.save, "Saved the user with already used password - same case"
    user_1 = User.new(:email => "HELLO@example.com", :password => "12345")
    assert_not user_1.save, "Saved the user with already used password - different case"
  end
end
