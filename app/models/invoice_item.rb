class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [ :pending, :packaged, :shipped ]

  def self.total_revenue(invoice)
    where(invoice_id: invoice.id).sum(:unit_price)
  end

  def top_discount
    available_discounts = item.merchant.bulk_discounts
    useable_discounts = available_discounts.where("bulk_discounts.quantity_threshold <= #{self.quantity}")
    useable_discounts.maximum(:discount) / 100
  end

  def find_by_invoice_id(invoice_id)
    invoice = Invoice.find(invoice_id)
    InvoiceItem.find(id)
  end
end
