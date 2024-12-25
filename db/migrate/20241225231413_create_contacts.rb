class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.integer :contact_type
      t.string :value
      t.references :applicant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
