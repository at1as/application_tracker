require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = User.create(email: 'abcdef@ghi.jkl', password: 'abcdef', password_confirmation: 'abcdef')
    session[:email] = @user.email
    session[:password] = @user.password
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    get :new
    post :create, session: {email: @user.email, password: @user.password }

    assert_redirected_to user_path(@user)
    assert_nil flash[:error]
  end

  test "should not login invalid email & password" do
    get :new
    post :create, session: {email: 'fakemail', password: 'wrong!'}
    
    assert_response :success
    assert_equal "Invalid email or password", flash[:error]
  end
  
  test "should not login - invalid password" do
    get :new
    post :create, session: {email: @user.email, password: 'wrong!'}
    
    assert_response :success
    assert_equal "Invalid email or password", flash[:error]
  end
  
  test "should not login - invalid email" do
    get :new
    post :create, session: {email: 'fakemail', password: @user.password}
    
    assert_response :success
    assert_equal "Invalid email or password", flash[:error]
  end
  
  test "should logout" do
    delete :destroy, session: {id: @user.id}
    assert_redirected_to '/'
  end
end
