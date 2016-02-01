require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @company = companies(:one)
    @event = events(:one)
    @user.companies << @company
    @company.events << @event
    
    session[:user_id] = @user.id
  end

  test "should get new" do
    get :new, {:user_id => @user.id, :company_id => @company.id}
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count', 1) do
      post :create, :user_id => @user.id, :company_id => @company.id, event: { date: '2016-01-01', event_type: 'Applied' }
    end
    
    assert_redirected_to user_company_path(@user, @company)
    assert_nil flash[:error]
    assert_equal "Event added", flash[:success]
  end
  
  test "should not create event - missing date" do
    assert_no_difference('Event.count') do
      post :create, :user_id => @user.id, :company_id => @company.id, event: { event_type: 'Applied' }
    end
  end
  
  test "should show event" do
    get :show, id: @event, :user_id => @user.id, :company_id => @company.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event, :user_id => @user.id, :company_id => @company.id
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, :user_id => @user.id, :company_id => @company.id, event: { date: '2016-01-02', event_type: 'Applied' }
    assert_redirected_to user_company_path(@user, @company)
    assert_nil flash[:error]
    assert_equal "Event updated", flash[:success]
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event, :user_id => @user.id, :company_id => @company.id
    end

    assert_redirected_to user_company_path(@user, @company)
    assert_equal "Event deleted!", flash[:success]
  end
end
