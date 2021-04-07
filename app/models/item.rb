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
end
