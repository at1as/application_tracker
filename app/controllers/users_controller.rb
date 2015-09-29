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
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(update_user_params)
      redirect to '/'
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destory
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
