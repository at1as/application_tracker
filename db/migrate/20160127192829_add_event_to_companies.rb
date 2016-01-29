class AddEventToCompanies < ActiveRecord::Migration
  def change
    add_reference :companies, :event, index: true, foreign_key: true
  end
end
