class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :date
      t.text :text

      t.timestamps null: false
    end
  end
end
