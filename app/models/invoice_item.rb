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
    if useable_discounts != []
      useable_discounts.maximum(:discount) / 100
    end
  end

  def find_by_invoice_id(invoice_id)
    invoice = Invoice.find(invoice_id)
    id = invoice.invoice_item_id
    InvoiceItem.find(id)
  end

  def discounted_revenue
    if top_discount.nil?
      unit_price * quantity
    else
      (unit_price * quantity) - ((unit_price * quantity) * top_discount)
    end
  end
end
