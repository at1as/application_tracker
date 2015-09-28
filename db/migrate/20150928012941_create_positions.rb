class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name
      t.string :url
      t.text :description
      t.integer :company_id

      t.timestamps null: false
    end
  end
end
