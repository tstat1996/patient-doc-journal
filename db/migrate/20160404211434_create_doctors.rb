class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :code

      t.timestamps null: false
    end
  end
end
