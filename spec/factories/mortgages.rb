# frozen_string_literal: true

FactoryBot.define do
  factory :mortgage do
    action_type { Mortgage.action_types.keys.sample } # Random valid action_type (buy or refinance)
    step { 0 } # Initial step
    completed { false } # Default to incomplete
    country { 'USA' }
    address { '123 Main Street' }
    zipcode { '12345' }
    property_type { Mortgage.property_types.keys.sample } # Random valid property_type
    price { 300_000.0 }
    down_payment { 60_000.0 }
    situation { Mortgage.situations.keys.sample } # Random valid situation
    purchase_date { Date.today }
    loan_duration { 10 } # 10 years
    monthly_payment { 1000.0 }
    interest_rate { 3.5 }
    reserve_amount { 10_000.0 }
    gift_funds { 5_000.0 }

    trait :step_0 do
      step { 0 }
      action_type { 'buy' }
    end

    trait :step_1 do
      step { 1 }
      country { 'USA' }
      address { '123 Main Street' }
      zipcode { '12345' }
    end

    trait :step_2 do
      step { 2 }
      property_type { 'single_family_home' }
    end

    trait :step_3 do
      step { 3 }
      price { 300_000.0 }
      down_payment { 60_000.0 }
    end

    trait :completed do
      step { 7 }
      completed { true }
    end
  end
end
