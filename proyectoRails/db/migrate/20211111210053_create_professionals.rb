class CreateProfessionals < ActiveRecord::Migration[6.1]
  def change
    create_table :professionals do |t|
      t.string :name
      t.string :surname

      t.timestamps
    end
  end
end
