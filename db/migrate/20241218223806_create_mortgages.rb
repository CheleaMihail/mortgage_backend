class CreateMortgages < ActiveRecord::Migration[8.0]
  def change
    create_table :mortgages do |t|
      t.integer :action_type
      t.string :country
      t.string :address
      t.string :zipcode
      t.integer :property_type
      t.decimal :price, precision: 15, scale: 2
      t.decimal :down_payment, precision: 15, scale: 2
      t.integer :situation
      t.date :purchase_date
      t.integer :loan_duration
      t.decimal :monthly_payment, precision: 15, scale: 2
      t.decimal :interest_rate, precision: 5, scale: 2
      t.decimal :reserve_amount, precision: 15, scale: 2
      t.decimal :gift_funds, precision: 15, scale: 2
      t.integer :step

      t.timestamps
    end
  end
end
