# frozen_string_literal: true

class MortgageSerializer < ActiveModel::Serializer
  attributes :id, :action_type, :country, :address, :zipcode, :property_type, :price, :down_payment,
             :situation, :purchase_date, :loan_duration, :monthly_payment, :interest_rate, :reserve_amount,
             :gift_funds, :step, :completed, :created_at, :updated_at

  def action_type
    object.action_type_before_type_cast
  end

  def property_type
    object.property_type_before_type_cast
  end

  def situation
    object.situation_before_type_cast
  end
end
