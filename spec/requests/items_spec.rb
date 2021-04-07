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

  describe 'Get an items merchant' do
    before { get "http://localhost:3000/api/v1/items/#{items.first.id}/merchant" }

    it 'finds all items' do
      expect(json.size).to eq(1)
      expect(json[:data][:attributes][:name]).to eq(items.first.merchant.name)
    end
  end

  describe 'Find all items happy path' do
    before { @item_1 = create(:item, name: "same", unit_price: 300) }
    before { @item_2 = create(:item, name: "Same", unit_price: 350) }
    before { @item_3 = create(:item, name: "saMe", unit_price: 360) }
    before { @item_4 = create(:item, name: "sorta same", unit_price: 200) }
    before { get "http://localhost:3000/api/v1/items/find_all?name=#{items.first.name}"}
    it 'finds all items that match a description' do
      expect(json[:data][0][:attributes].size).to eq(4)
      expect(json[:data][0][:attributes][:name]).to eq(items.first.name)
    end
  end

  describe 'Find all items sad path' do
    before { get "http://localhost:3000/api/v1/items/find_all?name=fdasfdasgads" }
    it 'puts an empty hash if no merchant is found' do
        expect(json[:data]).to eq([])
    end
  end

  describe 'find all items by min price happy path' do
    before { @item_1 = create(:item, name: "same", unit_price: 10000) }
    before { @item_2 = create(:item, name: "Same", unit_price: 10500) }
    before { @item_3 = create(:item, name: "saMe", unit_price: 10600) }
    before { @item_4 = create(:item, name: "sorta same", unit_price: 900) }
    before { get "http://localhost:3000/api/v1/items/find_all?min_price=10000" }
    it 'finds items by min price and above' do
      expect(json[:data].size).to eq(3)
    end
  end
  
  describe 'find all items by min price too high' do
    before { @item_1 = create(:item, name: "same", unit_price: 10000) }
    before { @item_2 = create(:item, name: "Same", unit_price: 10500) }
    before { @item_3 = create(:item, name: "saMe", unit_price: 10600) }
    before { @item_4 = create(:item, name: "sorta same", unit_price: 900) }
    before { get "http://localhost:3000/api/v1/items/find_all?min_price=1000000000" }
    it 'finds items by min price and above' do
      expect(json[:data].size).to eq(0)
    end
  end

  describe 'find all items by max price happy path' do
    before { @item_1 = create(:item, name: "same", unit_price: 1) }
    before { @item_2 = create(:item, name: "Same", unit_price: 2) }
    before { @item_3 = create(:item, name: "saMe", unit_price: 3) }
    before { @item_4 = create(:item, name: "sorta same", unit_price: 900) }
    before { get "http://localhost:3000/api/v1/items/find_all?max_price=4" }
    it 'finds items by min price and above' do
      expect(json[:data].size).to eq(3)
    end
  end

  describe 'find all items by max price too low' do
    before { @item_1 = create(:item, name: "same", unit_price: 1) }
    before { @item_2 = create(:item, name: "Same", unit_price: 2) }
    before { @item_3 = create(:item, name: "saMe", unit_price: 3) }
    before { @item_4 = create(:item, name: "sorta same", unit_price: 900) }
    before { get "http://localhost:3000/api/v1/items/find_all?max_price=0" }
    it 'finds items by min price and above' do
      expect(json[:data].size).to eq(0)
    end
  end
end