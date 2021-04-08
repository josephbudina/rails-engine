class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, :description, :unit_price, presence: true

  def self.find_by_name(name)
     where("name ILIKE ? or description LIKE ?", "%#{name}%", "%#{name}%")
  end

  scope :find_by_min_price, -> (price) { where('unit_price >= ?', price.to_i).order(:name)}
  
  scope :find_by_max_price, -> (price) { where('unit_price <= ?', price.to_i).order(:name)}

  def self.top_revenue(quantity)
    joins(invoices: :transactions)
    .where("transactions.result = ?", :success)
    .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .group(:id)
    .order(total_revenue: :desc)
    .limit(quantity)
  end

  def revenue
    invoices
    .joins(:transactions)
    .where("transactions.result = ?", :success)
    .pluck("sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
    .first
    .round(2)
  end
end
