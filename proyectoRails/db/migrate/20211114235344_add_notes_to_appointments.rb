class AddNotesToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :notes, :text
  end
end
