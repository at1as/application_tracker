require 'test_helper'

class PositionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @company = companies(:one)
    @position = positions(:one)
    @user.companies << @company
    @company.positions << @position
    
    session[:user_id] = @user.id
  end

  test "should get new" do
    get :new, {:user_id => @user.id, :company_id => @company.id}
    assert_response :success
  end

  test "should create position" do
    assert_difference('Position.count') do
      post :create, :user_id => @user.id, :company_id => @company.id, position: { name: 'p1' }
    end
    
    assert_redirected_to user_company_path(@user, @company)
    assert_nil flash[:error]
    assert_equal flash[:success], "Position created successfully"
  end

  test "should show position" do
    get :show, id: @position, :user_id => @user.id, :company_id => @company.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @position, :user_id => @user.id, :company_id => @company.id
    assert_response :success
  end

  test "should update position" do
    patch :update, id: @position, :user_id => @user.id, :company_id => @company.id, position: { name: 'p1' }
    assert_redirected_to user_company_path(@user, @company) #assigns(:position))
    assert_nil flash[:error]
    assert_equal flash[:success], "Position details updated"
  end

  test "should destroy position" do
    assert_difference('Position.count', -1) do
      delete :destroy, id: @position, :user_id => @user.id, :company_id => @company.id
    end

    assert_redirected_to user_company_path(@user, @company)
  end
end
