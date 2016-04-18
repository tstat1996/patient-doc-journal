class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :doctor_name

      t.timestamps null: false
    end
  end
end
