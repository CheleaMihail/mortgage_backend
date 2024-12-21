# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_12_19_212215) do
  create_table "mortgages", force: :cascade do |t|
    t.integer "action_type"
    t.string "country"
    t.string "address"
    t.string "zipcode"
    t.integer "property_type"
    t.decimal "price", precision: 15, scale: 2
    t.decimal "down_payment", precision: 15, scale: 2
    t.integer "situation"
    t.date "purchase_date"
    t.integer "loan_duration"
    t.decimal "monthly_payment", precision: 15, scale: 2
    t.decimal "interest_rate", precision: 5, scale: 2
    t.decimal "reserve_amount", precision: 15, scale: 2
    t.decimal "gift_funds", precision: 15, scale: 2
    t.integer "step"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed"
  end
end
