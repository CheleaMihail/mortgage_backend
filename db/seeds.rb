Mortgage.create!(
  action_type: :buy,
  step: 1,
  country: "USA",
  address: "123 Main St",
  zipcode: "12345",
  completed: false
)

Mortgage.create!(
  action_type: :refinance,
  step: 7,
  country: "USA",
  address: "456 Elm St",
  zipcode: "54321",
  property_type: :townhome,
  price: 200_000,
  down_payment: 50_000,
  situation: :self_employed_clinician,
  purchase_date: "2023-05-22",
  loan_duration: 20,
  monthly_payment: 1_200,
  interest_rate: 4.2,
  reserve_amount: 8_000,
  gift_funds: 3_000,
  completed: true
)
