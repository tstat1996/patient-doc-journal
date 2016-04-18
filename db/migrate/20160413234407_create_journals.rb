class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string :name
      t.string :body
      t.references :patient, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
