require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  let!(:items) { create_list(:item, 100) }
  let(:item_id) { items.first.id }
  
  describe 'GET /items' do

    before { get  api_v1_items_url }

    it 'returns items' do
      expect(json).not_to be_empty
      expect(json[:data].size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'get items 1' do

    before { get 'http://localhost:3000/api/v1/items?page=1' }

    it 'Has first 20 on page 1' do

      expect(json[:data].size).to eq(20)
      expect(json[:data][0][:attributes][:name]).to eq(items.first.name)
      expect(json[:data].last[:attributes][:name]).to eq(items[19].name)
    end
  end

  describe 'Check page 0' do
    before { get 'http://localhost:3000/api/v1/items?page=0' }
    it 'starts on page one if number below one is given' do

      expect(json[:data].size).to eq(20)
      expect(json[:data][0][:attributes][:name]).to eq(items.first.name)
      expect(json[:data].last[:attributes][:name]).to eq(items[19].name)
    end
  end

  describe 'list all items' do
    before { get 'http://localhost:3000/api/v1/items?page=1&per_page=200' }

    it 'Lists all items if given a large page' do
      expect(json[:data].size).to eq(100)
    end
  end

  describe 'GET api/v1/items/:id' do

    before { get api_v1_item_url(item_id) }

    context 'when the record exists' do
      it 'returns the item' do

        expect(json).not_to be_empty
        expect(json[:data][:id].to_i).to eq(item_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'No record exists' do
    context 'when the record doesnt exist' do

      it 'returns a 404' do
        expect{ get api_v1_item_url('1010192983743354634') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'Get a items items' do
    before { get "http://localhost:3000/api/v1/items/#{items.first.id}/merchant" }

    it 'finds all items' do
      expect(json.size).to eq(1)
      expect(json[:data][:attributes][:name]).to eq(items.first.merchant.name)
    end
  end
end