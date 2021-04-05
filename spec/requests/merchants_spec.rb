require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  let!(:merchants) { create_list(:merchant, 20) }
  let(:merchant_id) { merchants.first.id }

  describe 'GET /merchants' do

    before { get  api_v1_merchants_url }

    it 'returns Merchants' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET api/v1/merchants/:id' do
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
  end
end