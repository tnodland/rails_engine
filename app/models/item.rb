class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  belongs_to :merchant

  def self.most_revenue(limit)
    select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoice_items: {invoice: :transactions})
    .where(transactions: {result: 1})
    .group(:id)
    .order("revenue DESC")
    .limit(limit)
  end

  def self.most_items_sold(limit)
    select("items.*, sum(invoice_items.quantity) AS total_sold")
    .joins(invoice_items: {invoice: :transactions})
    .where(transactions: {result: 1})
    .group(:id)
    .order("total_sold DESC")
    .limit(limit)
  end

  def self.best_day(item_id)
    Invoice.select("invoices.created_at AS best_day")
    .joins(:transactions, :invoice_items)
    .where(invoice_items: {item_id: item_id}, transactions: {result: 1})
    .group(:created_at)
    .order("best_day DESC")
    .limit(1)
  end
end
