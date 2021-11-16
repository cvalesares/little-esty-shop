class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items

  enum status: [ "cancelled", "in progress", "completed" ]

  def self.pending_invoices
    joins(:invoice_items).where.not(invoice_items: {status: 'shipped'}).order(:created_at).uniq
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  # def discounted_revenue
  #   binding.pry
  #   all_discounts = Merchant.bulk_discounts
  #   joins(:invoice_items, :bulk_discounts).where("bulk_discounts.quantity_threshold <= ?", :quantity)
  # end
end
