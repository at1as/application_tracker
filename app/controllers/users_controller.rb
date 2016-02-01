class UsersController < ApplicationController

  before_action :logged_in_user, except: [:new, :create]

  def show
    @user = User.find(params[:id])
    @companies = @user.companies.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      log_in @user
      flash[:success] = "Account Created"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(update_user_params)
      flash[:success] = "Profile Updated"
      redirect_to '/'
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destory
  end

  def change_email
    @user = current_user
    
    render 'change_email'
  end

  def update_email
    @user = current_user
    
    if @user && @user.authenticate(params[:password])
      @user.update_attributes('email' => params[:email], 'password' => params[:password])
      
      if @user.save
        flash[:success] = "Profile Email Address Updated to #{@user.email}"
        redirect_to '/'
      else
        render 'change_email'
      end
    else
      flash[:error] = "Wrong Password"
      render 'change_email'
    end
  end


  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :remember_digest)
    end

    def update_user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
