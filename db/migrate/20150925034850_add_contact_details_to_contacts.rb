class AddContactDetailsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :email, :string
    add_column :contacts, :phone, :string
  end
end
