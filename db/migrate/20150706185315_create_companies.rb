class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :location
      t.string :size
      t.text :details

      t.timestamps
    end
  end
end
