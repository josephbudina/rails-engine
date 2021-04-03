require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  # initialize test data
  let!(:merchants) { create_list(:merchant, 20) }
  let(:merchant_id) { merchants.first.id }

  # Test suite for GET /merchants
  describe 'GET /merchants' do
    # make HTTP get request before each example
    before { get  api_v1_merchants_url }

    it 'returns Merchants' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /merchants/:id
  describe 'GET /merchants/:id' do
    before { get api_v1_merchant_url(merchant_id) }

    context 'when the record exists' do
      it 'returns the merchant' do
        expect(json).not_to be_empty
        expect(json['data']['id'].to_i).to eq(merchant_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

  #   context 'when the record does not exist' do
  #     let(:merchant_id) { 100 }

  #     it 'returns status code 404' do
  #       expect(response).to have_http_status(404)
  #     end

  #     it 'returns a not found message' do
  #       expect(response.body).to match(/Couldn't find merchant/)
  #     end
  #   end
  end
end