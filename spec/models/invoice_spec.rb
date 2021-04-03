require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before :each do
    # @customer1 = Customer.create(first_name: "Joe",
    #                              last_name: "Smith")
    # @invoice1 = @customer1.invoices.create(status: 0)
    # @invoice2 = @customer1.invoices.create(status: 1)
    # @invoice3 = @customer1.invoices.create(status: 2)
    # @invoice4 = @customer1.invoices.create(status: 0)

    # @merchant = Merchant.create(name: "John's Jewelry")
    # @item1 = @merchant.items.create(name: "Gold Ring", description: "14K Wedding Band",
    #                                 unit_price: 599.95)
    # @item2 = @merchant.items.create(name: "Diamond Ring", description: "Shiny",
    #                                 unit_price: 1000.00)
    # @item3 = @merchant.items.create(name: "Silver Ring", description: "Plain",
    #                                 unit_price: 350.00)
    # @item4 = @merchant.items.create(name: "Mood Ring", description: "Strong mood vibes",
    #                                 unit_price: 100.00)
    # @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id,
    #                                      item_id: @item1.id, quantity: 500,
    #                                      unit_price: 599.95, status: 0)
    # @invoice_item2 = InvoiceItem.create!(invoice_id: @invoice2.id,
    #                                      item_id: @item2.id, quantity: 200,
    #                                      unit_price: 1000.00, status: 0)
    # @invoice_item3 = InvoiceItem.create!(invoice_id: @invoice3.id,
    #                                      item_id: @item1.id, quantity: 100,
    #                                      unit_price: 350.00, status: 0)
    # @invoice_item4 = InvoiceItem.create!(invoice_id: @invoice4.id,
    #                                      item_id: @item4.id, quantity: 400,
    #                                      unit_price: 100.00, status: 0)
  end

  describe "relationships" do
    it {should belong_to :customer}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
  end
end
