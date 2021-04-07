class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.find_one(name)
    order(name: :asc).find_by("name ILIKE ?", "%#{name}%")
  end

  def self.top_revenue(quantity)
    joins(:transactions)
    .where("transactions.result = ?", :success)
    .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .group(:id)
    .order(total_revenue: :desc)
    .limit(quantity)
  end

  def revenue
    transactions
    .where("transactions.result = ?", :success)
    .pluck("sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .first
    .round(2)
  end
end
