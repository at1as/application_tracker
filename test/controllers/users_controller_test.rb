require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: 'test@test.test', password: 'test1234', password_confirmation: 'test1234' }
    end
    
    assert_redirected_to user_path(User.last)
    assert_nil flash[:error]
    assert_equal "Account Created", flash[:success]
  end
  
  test "should not create user - invalid email" do
    assert_no_difference('User.count') do
      post :create, user: { email: 'invalid_email', password: 'test1234', password_confirmation: 'test1234' }
    end
    
    assert_nil flash[:success]
  end
  
  test "should not create user - invalid password" do
    assert_no_difference('User.count') do
      post :create, user: { email: 'test@test.test', password: 'test', password_confirmation: 'test' }
    end
    
    assert_nil flash[:success]
  end
  
  test "should not create user - unmatching password confirmation" do
    assert_no_difference('User.count') do
      post :create, user: { email: 'test@test.test', password: 'test1234', password_confirmation: 'test12345' }
    end
    
    assert_nil flash[:success]
  end
end
