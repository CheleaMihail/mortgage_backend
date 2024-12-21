class Mortgage < ApplicationRecord
  enum :action_type, buy: 0, refinance: 1
  enum :property_type, single_family_home: 0, townhome: 1, condominium: 2, apartment: 3, other: 4
  enum :situation, practicing_hospitalist: 0, exiting_residency: 1, exiting_fellowship: 2, self_employed_clinician: 3

  validates :step, presence: true, inclusion: { in: 0..7 }
  validates :action_type, presence: true, inclusion: { in: action_types.keys }, if: -> { step >= 0 }
  validates :country, :address, :zipcode, presence: true, if: -> { step >= 1 }
  validates :property_type, presence: true, inclusion: { in: property_types.keys }, if: -> { step >= 2 }
  validates :price, :down_payment, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: -> { step >= 3 }
  validates :situation, presence: true, inclusion: { in: situations.keys }, if: -> { step >= 4 }
  validates :purchase_date, presence: true, if: -> { step >= 5 }
  validates :loan_duration, :interest_rate, :reserve_amount,
            presence: true, numericality: { greater_than_or_equal_to: 0 }, if: -> { step >= 6 }
  validates :gift_funds, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: -> { step >= 7 }

  before_save :calculate_monthly_payment, if: -> { step >= 6 }
  before_save :check_completion

  private

  def calculate_monthly_payment
    if price.present? && loan_duration.present? && loan_duration > 0
      self.monthly_payment = price / loan_duration
    else
      self.monthly_payment = nil
    end
  end

  def check_completion
    self.completed = step == 7
  end
end
