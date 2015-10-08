class CompaniesController < ApplicationController
  
  before_action :logged_in_user

  def index
    @user = current_user
    @companies = @user.companies.paginate(page: params[:page])
  end

  def new
    @user = current_user
    @company = Company.new
  end

  def edit
    @user = current_user
    @company = Company.find(params[:id])
  end

  def show
    @user = current_user
    @company = Company.find(params[:id])
    @contacts = @company.contacts.paginate(page: params[:page])
    @positions = @company.positions.paginate(page: params[:page])
  end

  def create
    @user = current_user
    @company = current_user.companies.build(company_params)

    if @company.save
      flash[:success] = "Company profile created"
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def update
    @user = current_user
    @company = Company.find(params[:id])

    if @company.update(company_params)
      flash[:success] = "Company profile updated"
      redirect_to user_company_path(current_user, @company)
    else
      render 'edit'
    end
  end

  def destroy
    @company = Company.find(params[:id])

    @company.destroy
    redirect_to user_path(current_user), :flash => { :success => "Company deleted!" }
  end

  def remove_attachment
    @user = current_user
    @company = Company.find(params[:id])
    @company.attachment = nil
    @company.save

    redirect_to user_company_path(@user, @company), flash: { success: 'Attachment has been removed.' }
  end

  private
    def company_params
      params.require(:company).permit(:name, :status, :location, :size, :website, :details, :attachment)
    end

end
