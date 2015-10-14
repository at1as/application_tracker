class CompaniesController < ApplicationController
  
  before_action :logged_in_user
  MAX_POSTGRES_INT = 2147483647

  def filter
    @user = current_user

    conditions = {}
    conditions[:name] = params[:filter_name] unless params[:filter_name].blank?
    conditions[:status] = params[:filter_status] unless params[:filter_status].blank?
    conditions[:location] = params[:filter_location] unless params[:filter_location].blank?

    # Size Conditions
    if !params[:filter_size_min].blank? || !params[:filter_size_max].blank?
      params[:filter_size_min].blank? ? min_size = 1 : min_size = params[:filter_size_min].to_i
      params[:filter_size_max].blank? ? max_size = MAX_POSTGRES_INT : max_size = params[:filter_size_max].to_i
      conditions[:size] = (min_size..max_size)
    end

    # Date Conditions
    if !params[:filter_updated_year].blank? || !params[:filter_updated_month].blank? || !params[:filter_updated_day].blank?
      
      params[:filter_updated_year].blank? ? date = "#{Time.now.year}" : date = "#{params[:filter_updated_year]}" 
      params[:filter_updated_month].blank? ? date = date + "-01" : date = date + "-#{params[:filter_updated_month]}"
      params[:filter_updated_day].blank? ? date = date + "-01" : date = date + "-#{params[:filter_updated_day]}"
      
      date = Time.parse(date)
      conditions[:updated_at] = date..Time.now.tomorrow
    end
    
    @companies = @user.companies.where(conditions).paginate(page: params[:page])
    @length = @companies.length

    render :partial => 'company', collection: @companies
  end

  def index
    @user = current_user

    @companies = @user.companies.paginate(page: params[:page])
    @length = @companies.length
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
    redirect_to user_companies_path(current_user), :flash => { :success => "Company deleted!" }
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
