require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant)
    @merchant6 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)

    @item3 = create(:item, merchant_id: @merchant2.id)
    @item4 = create(:item, merchant_id: @merchant3.id)
    @item5 = create(:item, merchant_id: @merchant4.id)
    @item6 = create(:item, merchant_id: @merchant5.id)
    @item7 = create(:item, merchant_id: @merchant6.id)
    @item8 = create(:item, merchant_id: @merchant1.id)


    @customers = []
    15.times {@customers << create(:customer)}
    @customers.each do |customer|
      create(:invoice, customer_id: customer.id)
    end

    @invoice_1 = @customers.first.invoices.first
    @invoice_2 = @customers.second.invoices.first
    @invoice_3 = @customers.third.invoices.first
    @invoice_4 = @customers.fourth.invoices.first
    @invoice_5 = @customers[4].invoices.first
    @invoice_6 = @customers[5].invoices.first
    @invoice_7 = @customers[7].invoices.first
    @invoice_8 = @customers[8].invoices.first
    @invoice_9 = @customers[9].invoices.first
    @invoice_10 = @customers[10].invoices.first
    @invoice_11 = @customers[4].invoices.first
    9.times {create(:transaction, invoice_id: @invoice_1.id, result: "success")}
    8.times {create(:transaction, invoice_id: @invoice_2.id, result: "success")}
    7.times {create(:transaction, invoice_id: @invoice_3.id, result: "success")}
    6.times {create(:transaction, invoice_id: @invoice_4.id, result: "success")}
    5.times {create(:transaction, invoice_id: @invoice_8.id, result: "success")}
    5.times {create(:transaction, invoice_id: @invoice_9.id, result: "success")}
    5.times {create(:transaction, invoice_id: @invoice_10.id, result: 0)}
    5.times {create(:transaction, invoice_id: @invoice_5.id, result: 0)}
    5.times {create(:transaction, invoice_id: @invoice_6.id, result: 1)}
    5.times {create(:transaction, invoice_id: @invoice_7.id, result: 1)}
    5.times {create(:transaction, invoice_id: @invoice_11.id, result: 1)}


    @invoice_item_1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 50.0)
    @invoice_item_2 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice_2.id, quantity: 12, unit_price: 60.54)
    @invoice_item_3 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice_3.id, quantity: 45, unit_price: 70.54)
    @invoice_item_4 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice_4.id, quantity: 32, unit_price: 80.6)
    @invoice_item_5 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice_8.id, quantity: 200, unit_price: 90.7)
    @invoice_item_6 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice_9.id, quantity: 100, unit_price: 90.7)
    @invoice_item_7 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice_10.id, quantity: 300, unit_price: 90.7)
    @invoice_item_8 = create(:invoice_item, item_id: @item6.id, invoice_id: @invoice_8.id, quantity: 400, unit_price: 90.7)
    @invoice_item_9 = create(:invoice_item, item_id: @item7.id, invoice_id: @invoice_9.id, quantity: 185, unit_price: 90.7)
    @invoice_item_10 = create(:invoice_item, item_id: @item8.id, invoice_id: @invoice_11.id, quantity: 1, unit_price: 90.7)
  end

  describe 'Class Methods' do
    it '#find_one' do
      expect(Merchant.find_one(@merchant1.name)).to eq(@merchant1)
    end

    it '#top_revenue' do
      expect(Merchant.top_revenue(1)).to eq([@merchant5])
    end

    it '#most_items' do
      expect(Merchant.most_items(6)).to eq([@merchant5,@merchant2,@merchant6,@merchant1,@merchant3])
    end
  end

  describe 'Instance Methods' do
    it '::revenue' do
      expect(@merchant1.revenue).to eq(45757.14)
    end

    it '::merchant_item_count' do
      expect(@merchant1.merchant_item_count).to eq(648)
    end
  end
end
