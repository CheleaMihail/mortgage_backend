require 'rails_helper'

RSpec.describe "Api::V1::Mortgages", type: :request do
  let!(:mortgage) { create(:mortgage, completed: false) }
  let(:valid_attributes) do
    {
      step: 0,
      action_type: "buy" # Assuming step 0 requires only this field
    }
  end
  let(:invalid_attributes) { { step: 1, country: nil, address: nil, zipcode: nil } }

  describe "GET /api/v1/mortgages" do
    context "when there is an incomplete mortgage" do
      it "returns the first incomplete mortgage" do
        get "/api/v1/mortgages"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["id"]).to eq(mortgage.id)
      end
    end

    context "when there is no incomplete mortgage" do
      before { Mortgage.update_all(completed: true) } # Mark all mortgages as complete

      it "returns a message indicating no incomplete mortgage" do
        get "/api/v1/mortgages"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["message"]).to eq("No incomplete mortgage found")
      end
    end
  end

  describe "POST /api/v1/mortgages" do
    context "with valid parameters" do
      it "creates a new mortgage" do
        expect {
          post "/api/v1/mortgages", params: { mortgage: valid_attributes }
        }.to change(Mortgage, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new mortgage and returns errors" do
        invalid_attributes = { step: 0, action_type: nil } # Missing required field
        expect {
          post "/api/v1/mortgages", params: { mortgage: invalid_attributes }
        }.not_to change(Mortgage, :count)
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]).not_to be_empty
      end
    end
  end

  describe "PATCH /api/v1/mortgages/:id" do
    context "with valid parameters" do
      it "updates the requested mortgage" do
        valid_attributes = { step: 1, country: "USA", address: "123 Main St", zipcode: "12345" }
        patch "/api/v1/mortgages/#{mortgage.id}", params: { mortgage: valid_attributes }
        expect(response).to have_http_status(:ok)
        mortgage.reload
        expect(mortgage.country).to eq("USA")
      end
    end

    context "with invalid parameters" do
      it "does not update the mortgage and returns errors" do
        patch "/api/v1/mortgages/#{mortgage.id}", params: { mortgage: invalid_attributes }
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]).not_to be_empty
        mortgage.reload
        expect(mortgage.country).not_to be_nil # Ensures invalid update did not proceed
      end
    end
  end

  describe "GET /api/v1/mortgages/:id" do
    context "when the mortgage exists" do
      it "returns the requested mortgage" do
        get "/api/v1/mortgages/#{mortgage.id}"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["id"]).to eq(mortgage.id)
      end
    end

    context "when the mortgage does not exist" do
      it "returns not found error" do
        get "/api/v1/mortgages/0"
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]).to eq("Mortgage not found")
      end
    end
  end
end
