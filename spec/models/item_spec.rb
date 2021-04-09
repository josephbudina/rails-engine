require 'rails_helper'

RSpec.describe Item, type: :model do
  before :each do
    @customer1 = Customer.create(first_name: "Joe", last_name: "Smith")
    @merchant1 = Merchant.create(name: "Pawtrait Designs")
    @item1 = @merchant1.items.create(name: "Puppy Portrait",
                                     description: "Wall art of your favorite pup",
                                     unit_price: 10.99)
    @item2 = @merchant1.items.create(name: "Kitty Portrait",
                                     description: "5x7 of your favorite cat",
                                     unit_price: 6.99)
    @item3 = @merchant1.items.create(name: "Pet Portrait",
                                     description: "8x10 of all your favorite pets",
                                     unit_price: 8.99)
    @invoice1 = @customer1.invoices.create
    @invoice2 = @customer1.invoices.create
    @invoice3 = @customer1.invoices.create
    @invoice_item1 = InvoiceItem.create(item_id: @item1.id,
                                        invoice_id: @invoice1.id,
                                        quantity: 150,
                                        unit_price: 10.99)
    @invoice_item2 = InvoiceItem.create(item_id: @item2.id,
                                        invoice_id: @invoice2.id,
                                        quantity: 100,
                                        unit_price: 10.99)
    @invoice_item3 = InvoiceItem.create(item_id: @item3.id,
                                        invoice_id: @invoice3.id,
                                        quantity: 500,
                                        unit_price: 6.99)
    @transaction1 = Transaction.create(invoice_id: @invoice1.id, result: "success" )
    @transaction2 = Transaction.create(invoice_id: @invoice2.id, result: "success" )
    @transaction3 = Transaction.create(invoice_id: @invoice3.id, result: "success" )
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'Class Methods' do
    it '#find_by_name' do
      expect(Item.find_by_name("portrait")).to eq([@item1, @item2, @item3])
    end

    it '#top_revenue' do
      expect(Item.top_revenue(1)).to eq([@item3])
    end

    it '#revenue' do
      expect(@item1.revenue).to eq(1648.5)
      expect(@item2.revenue).to eq(1099.0)
      expect(@item3.revenue).to eq(3495.0)
    end
  end
end
