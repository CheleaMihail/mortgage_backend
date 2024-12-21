# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MortgagesController, type: :controller do
  let(:valid_attributes) do
    {
      action_type: 'buy',
      step: 0
    }
  end

  let(:invalid_attributes) do
    {
      action_type: 0,
      step: 1
    }
  end

  let!(:incomplete_mortgage) { create(:mortgage, completed: false, step: 3) }
  let!(:complete_mortgage) { create(:mortgage, completed: true, step: 7) }

  describe 'GET #index' do
    it 'returns the first incomplete mortgage if exists' do
      get :index
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(incomplete_mortgage.id)
    end

    it 'returns a message if no incomplete mortgage is found' do
      incomplete_mortgage.update(step: 7, completed: true)
      get :index
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('No incomplete mortgage found')
    end
  end

  describe 'GET #show' do
    it 'returns the requested mortgage' do
      get :show, params: { id: incomplete_mortgage.id }
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(incomplete_mortgage.id)
    end

    it 'returns an error if the mortgage is not found' do
      get :show, params: { id: 'invalid_id' }
      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Mortgage not found')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new mortgage' do
        expect do
          post :create, params: { mortgage: valid_attributes }
        end.to change(Mortgage, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new mortgage and returns errors' do
        expect do
          post :create, params: { mortgage: invalid_attributes }
        end.not_to change(Mortgage, :count)
        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include('Action type is not included in the list')
      end
    end
  end

  describe 'PATCH/PUT #update' do
    context 'with valid parameters' do
      it 'updates the mortgage' do
        patch :update, params: { id: incomplete_mortgage.id, mortgage: { step: 4 } }
        expect(response).to have_http_status(:ok)
        incomplete_mortgage.reload
        expect(incomplete_mortgage.step).to eq(4)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the mortgage and returns errors' do
        patch :update, params: { id: incomplete_mortgage.id, mortgage: { step: 8 } }
        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include('Step is not included in the list')
      end
    end
  end
end
