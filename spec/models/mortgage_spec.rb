require 'rails_helper'

RSpec.describe Mortgage, type: :model do
  # Create a sample mortgage instance
  let(:mortgage) { create(:mortgage) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(mortgage).to be_valid
    end

    it "is invalid with wrong step" do
      mortgage.step = 10
      expect(mortgage).to_not be_valid
    end


    it "is invalid without a country" do
      mortgage.step = 1
      mortgage.country = nil
      expect(mortgage).to_not be_valid
    end

    it "is invalid without an address" do
      mortgage.step = 1
      mortgage.address = nil
      expect(mortgage).to_not be_valid
    end

    it "is invalid without a zipcode" do
      mortgage.step = 1
      mortgage.zipcode = nil
      expect(mortgage).to_not be_valid
    end

    it "is invalid without a price" do
      mortgage.step = 3
      mortgage.price = nil
      expect(mortgage).to_not be_valid
    end

    it "is invalid with a negative down_payment" do
      mortgage.step = 3
      mortgage.down_payment = -5000
      expect(mortgage).to_not be_valid
    end

    it "is invalid without a purchase_date" do
      mortgage.step = 5
      mortgage.purchase_date = nil
      expect(mortgage).to_not be_valid
    end

    it "is invalid with a negative loan_duration" do
      mortgage.step = 6
      mortgage.loan_duration = -1
      expect(mortgage).to_not be_valid
    end

    it "is invalid with a negative interest_rate" do
      mortgage.step = 6
      mortgage.interest_rate = -0.5
      expect(mortgage).to_not be_valid
    end

    it "is invalid with a negative reserve_amount" do
      mortgage.step = 6
      mortgage.reserve_amount = -1000
      expect(mortgage).to_not be_valid
    end

    it "is invalid with a negative gift_funds" do
      mortgage.step = 7
      mortgage.gift_funds = -1000
      expect(mortgage).to_not be_valid
    end
  end

  describe "#calculate_monthly_payment" do
    it "calculates monthly payment correctly" do
      mortgage.step = 6
      mortgage.price = 300000
      mortgage.loan_duration = 30
      mortgage.save
      expect(mortgage.monthly_payment).to eq(0.1e5)  # 300000 / 30
    end

    it "does not calculate if price or loan_duration is zero" do
      mortgage.step = 6 
      mortgage.price = 10000
      mortgage.loan_duration = 0
      mortgage.save
      expect(mortgage.monthly_payment).to be_nil
    end
  end

  describe "#check_completion" do
    it "sets completed to true if step is 7" do
      mortgage.step = 7
      mortgage.save
      expect(mortgage.completed).to be true
    end

    it "sets completed to false if step is not 7" do
      mortgage.step = 6
      mortgage.save
      expect(mortgage.completed).to be false
    end
  end
end
