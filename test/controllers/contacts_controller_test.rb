require 'test_helper'

class ContactsControllerTest < ActionController::TestCase

  setup do
    @user = users(:one)
    @company = companies(:one)
    @contact = contacts(:one)
    @user.companies << @company
    @company.contacts << @contact
    session[:user_id] = @user.id
  end

  test "should get new" do
    get :new, :user_id => @user.id, :company_id => @company.id
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count', 1) do
      post :create, :user_id => @user.id, :company_id => @company.id, contact: { name: 'c1' }
    end
    
    assert_redirected_to user_company_path(@user, @company)
    assert_nil flash[:error]
    assert_equal flash['alert-success'], "Contact profile created"
  end

  test "should show contact" do
    get :show, id: @contact, :user_id => @user.id, :company_id => @company.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact, :user_id => @user.id, :company_id => @company.id
    assert_response :success
  end

  test "should update contact" do
    patch :update, id: @contact, :user_id => @user.id, :company_id => @company.id, contact: { name: 'c2' }
    assert_redirected_to user_company_path(@user, @company) #assigns(:position))
    assert_nil flash[:error]
    assert_equal flash['alert-success'], "Contact details updated"
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete :destroy, id: @contact, :user_id => @user.id, :company_id => @company.id
    end

    assert_redirected_to user_company_path(@user, @company)
    assert_equal "Contact deleted!", flash['alert-success']
  end
end
