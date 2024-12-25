class CreateApplicants < ActiveRecord::Migration[8.0]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :document
      t.date :birth_date
      t.decimal :salary, precision: 10, scale: 2
      t.decimal :inss_discount, precision: 10, scale: 2

      t.timestamps
    end
    add_index :applicants, :document, unique: true
  end
end
