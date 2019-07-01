class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items

  def self.most_revenue(limit)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_sold")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 1})
    .order("total_sold DESC")
    .group(:id)
    .limit(limit)
  end

  def self.most_items(limit)
    select("merchants.*, sum(invoice_items.quantity) AS total_items")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 1})
    .order("total_items DESC")
    .group(:id)
    .limit(limit)
  end

  def total_revenue
    invoices.select("sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 1})
    .group(:merchant_id)
  end

  def self.revenue_by_date(date)
    Invoice.select("date_trunc('day', invoices.created_at) AS date, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 1}, invoices: {created_at: Time.parse(date).utc.all_day})
    .group("date")
  end

  def self.favorite_customer(merchant_id)
    Customer.select("customers.*, count(customers.id)")
    .joins(invoices: :transactions)
    .where(invoices: {merchant_id: merchant_id}, transactions: {result: 1})
    .group(:id)
    .order("count DESC")
    .limit(1)
  end

  def total_revenue_by_date(date)
    invoices.select("sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 1}, invoices: {created_at: Time.parse(date).utc.all_day})
    .group(:merchant_id)
  end
end
