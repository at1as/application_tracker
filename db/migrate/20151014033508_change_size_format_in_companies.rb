class ChangeSizeFormatInCompanies < ActiveRecord::Migration
  def change
    change_column :companies, :size, "integer USING NULLIF(size, '')::int", :null => true
  end
end
