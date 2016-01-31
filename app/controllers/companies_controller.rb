class CompaniesController < ApplicationController
  
  before_action :logged_in_user

  def filter
    @user = current_user

    # Construct Updated_At Conditions from form before sending to model for query
    if !params[:filter_updated_year].blank? || !params[:filter_updated_month].blank? || !params[:filter_updated_day].blank?
     
      # If any date field is present, construct date query with:
      #   default year set to current year, default month set to January, default day set to 1
      params[:filter_updated_year].blank? ? date = "#{Time.now.year}" : date = "#{valid_range(params[:filter_updated_year], 2000, 2020)}"
      params[:filter_updated_month].blank? ? date = date + "-01" : date = date + "-#{valid_range(params[:filter_updated_month], 1, 12)}"
      params[:filter_updated_day].blank? ? date = date + "-01" : date = date + "-#{valid_range(params[:filter_updated_day], 1, 31)}"
      
      params[:date] = Time.parse(date) rescue nil
    end

    @companies = @user.companies.filter(params).paginate(page: params[:page])
    @length = @companies.length

    render :partial => 'company', collection: @companies
  end

  def calendar
    @user = current_user
    @companies = Company.all
    @events = []
    @user.companies.each{ |company| company.events.each { |event| @events << event } }
    #u1.companies.each{ |c| c.events.each {|e| zz << e }} }
    #@events = @user.companies.each{ |company| company.events }.flatten
    render :calendar
  end

  def to_csv
    @user = current_user

    respond_to do |format|
      format.csv do
        csv_name = "#{params[:csv_type]}-#{Date.today}.csv"
        
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=#{csv_name}"
        if params[:csv_type] == "companies"
          send_data @user.companies.to_csv, filename: csv_name
        else
          send_data @user.companies.to_nested_csv(params[:csv_type]), filename: csv_name
        end
      end
    end
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
    @events = @company.events.paginate(page: params[:page])
  end

  def create
    @user = current_user
    @company = current_user.companies.build(company_params)

    if @company.save
      flash[:success] = "Company profile created"
      redirect_to user_companies_path(current_user)
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
      params.require(:company).permit(:name, :status, :location, :size, :website, :details, :attachment, :csv_type)
    end

    def valid_range(num, min, max)
      if num.to_i < min
        return min
      elsif num.to_i > max
        return max
      else
        return num.to_i
      end
    end
end
