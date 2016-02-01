require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @company = companies(:one)
    @user.companies << @company
    session[:user_id] = @user.id
  end
  
  test "should get new" do
    get :new, :user_id => @user.id
    assert_response :success
  end

end
