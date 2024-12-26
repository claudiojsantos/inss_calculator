class CreateInssBrackets < ActiveRecord::Migration[8.0]
  def change
    create_table :inss_brackets do |t|
      t.decimal :min_salary, precision: 10, scale: 2
      t.decimal :max_salary, precision: 10, scale: 2
      t.decimal :rate, precision: 5, scale: 2

      t.timestamps
    end
  end
end
