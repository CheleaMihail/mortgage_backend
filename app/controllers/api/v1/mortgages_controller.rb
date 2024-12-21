module Api
  module V1
    class MortgagesController < ApplicationController
      before_action :set_mortgage, only: [ :show, :update ]

      def index
        # Fetch the first incomplete mortgage (if exist)
        incomplete_mortgage = Mortgage.where(completed: false).first
        if incomplete_mortgage
          render json: incomplete_mortgage, serializer: MortgageSerializer, status: :ok
        else
          render json: { message: "No incomplete mortgage found" }, status: :ok
        end
      end

      def create
        mortgage = Mortgage.new(mortgage_params)
        if mortgage.save
          render json: mortgage, status: :created
        else
          render json: { errors: mortgage.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        @mortgage.assign_attributes(mortgage_params)

        if @mortgage.valid? && @mortgage.save
          render json: @mortgage, status: :ok
        else
          render json: { errors: @mortgage.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: @mortgage
      end

      private

      def set_mortgage
        @mortgage = Mortgage.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Mortgage not found" }, status: :not_found
      end

      def mortgage_params
        step = params[:mortgage][:step].to_i rescue 0
        permitted_fields = [ :step, *step_fields(step) ]
        params.require(:mortgage).permit(*permitted_fields)
      end

      def step_fields(step)
        case step
        when 0  then [ :action_type ]
        when 1 then [ :country, :address, :zipcode ]
        when 2 then [ :property_type ]
        when 3 then [ :price, :down_payment ]
        when 4 then [ :situation ]
        when 5 then [ :purchase_date ]
        when 6 then [ :loan_duration, :monthly_payment, :interest_rate, :reserve_amount ]
        when 7 then [ :gift_funds ]
        else []
        end
      end
    end
  end
end
