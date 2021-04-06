require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  let!(:merchants) { create_list(:merchant, 100) }
  let(:merchant_id) { merchants.first.id }

  describe 'GET /merchants' do

    before { get  api_v1_merchants_url }

    it 'returns Merchants' do
      expect(json).not_to be_empty
      expect(json[:data].size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'get merchants 1' do

    before { get 'http://localhost:3000/api/v1/merchants?page=1' }

    it 'Has first 20 on page 1' do

      expect(json[:data].size).to eq(20)
      expect(json[:data][0][:attributes][:name]).to eq(merchants.first.name)
      expect(json[:data].last[:attributes][:name]).to eq(merchants[19].name)
    end
  end

  describe 'Check page 0' do
    before { get 'http://localhost:3000/api/v1/merchants?page=0' }
    it 'starts on page one if number below one is given' do

      expect(json[:data].size).to eq(20)
      expect(json[:data][0][:attributes][:name]).to eq(merchants.first.name)
      expect(json[:data].last[:attributes][:name]).to eq(merchants[19].name)
    end
  end

  describe 'list all merchants' do
    before { get 'http://localhost:3000/api/v1/merchants?page=1&per_page=200' }

    it 'Lists all merchants if given a large page' do
      expect(json[:data].size).to eq(100)
    end
  end

  describe 'GET api/v1/merchants/:id' do
    
    before { get api_v1_merchant_url(merchant_id) }

    context 'when the record exists' do
      it 'returns the merchant' do

        expect(json).not_to be_empty
        expect(json[:data][:id].to_i).to eq(merchant_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'No record exists' do
    context 'when the record doesnt exist' do

      it 'returns a 404' do
        expect{ get api_v1_merchant_url('1010192983743354634') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'Get a merchants items' do
    before { @item_1 = merchants.first.items.create(attributes_for(:item)) }
    before { @item_2 = merchants.first.items.create(attributes_for(:item)) }
    before { get "http://localhost:3000/api/v1/merchants/#{merchants.first.id}/items" }
    
    it 'finds all items' do

      expect(json[:data].size).to eq(2)
      expect(json[:data][0][:attributes][:name]).to eq(@item_1.name)
      expect(json[:data].last[:attributes][:name]).to eq(@item_2.name)
    end
  end

  describe 'Find one merchant happy path' do
    before { get "http://localhost:3000/api/v1/merchants/find?name=#{merchants.first.name}"}

    it 'finds one merchant by name' do
      expect(json[:data].size).to eq(3)
      expect(json[:data][:attributes][:name]).to eq(merchants.first.name)
    end
  end

  describe 'Find one merchant sad path' do
    before { get "http://localhost:3000/api/v1/merchants/find?name=fdasfdasgads" }
      it 'puts an empty hash if no merchant is found' do
      expect(json[:data]).to eq({})
    end
  end
end