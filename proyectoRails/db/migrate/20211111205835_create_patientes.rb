class CreatePatientes < ActiveRecord::Migration[6.1]
  def change
    create_table :patientes do |t|
      t.string :name
      t.string :surname
      t.integer :phone

      t.timestamps
    end
  end
end
