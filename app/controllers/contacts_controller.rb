class ContactsController < ApplicationController

  def new
    @user = current_user
    @company = Company.find(params[:company_id])
    @contact = Contact.new
  end

  def show
    @user = current_user
    @company = Company.find(params[:company_id])
    @contact = Contact.find(params[:id])
  end

  def edit
    @user = current_user
    @company = Company.find(params[:company_id])
    @contact = Contact.find(params[:id])
  end

  def create
    @user = current_user
    @company = Company.find(params[:company_id])
    @contact = @company.contacts.build(contact_params)
    
    if @contact.save
      flash[:success] = "Contact profile created"
      redirect_to user_company_path(current_user, @company)
    else
      render 'new'
    end
  end

  def update
    @company = Company.find(params[:company_id])
    @contact = Contact.find(params[:id])

    if @contact.update(contact_params)
      flash[:success] = "Contact details updated"
      redirect_to user_company_path(current_user, @company)
    else
      render 'edit'
    end
  end

  def destroy
    @company = Company.find(params[:company_id])
    @contact = Contact.find(params[:id])

    @contact.destroy
    redirect_to user_company_path(current_user, @company), :flash => {:success => "Contact deleted!" }
  end
    
  private
    def contact_params
      params.require(:contact).permit(:name, :position, :location, :phone, :email, :details)
    end
end
