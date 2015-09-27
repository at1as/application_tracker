class AddUserRefToCompany < ActiveRecord::Migration
  def change
    add_reference :companies, :user, index: true
  end
end
