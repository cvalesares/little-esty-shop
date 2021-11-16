class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [ :pending, :packaged, :shipped ]

  def self.total_revenue(invoice)
    where(invoice_id: invoice.id).sum(:unit_price)
  end

  def best_discount
    available_discounts = item.merchant.bulk_discounts
    useable_discounts = available_discounts.where("bulk_discounts.quantity_threshold <= #{self.quantity}")
    useable_discounts.maximum(:discount)/100
  end
end
