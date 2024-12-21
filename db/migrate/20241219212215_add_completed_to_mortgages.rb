# frozen_string_literal: true

class AddCompletedToMortgages < ActiveRecord::Migration[8.0]
  def change
    add_column :mortgages, :completed, :boolean, default: false
  end
end
