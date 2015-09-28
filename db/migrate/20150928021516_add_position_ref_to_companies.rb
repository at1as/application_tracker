class AddPositionRefToCompanies < ActiveRecord::Migration
  def change
    add_reference :companies, :position, index: true, foreign_key: true
  end
end
