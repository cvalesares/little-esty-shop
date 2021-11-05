class Merchant < ApplicationRecord
  has_many :items

  def favorite_customers
    Customer.joins(invoices: [:transactions, [invoice_items: [item: [:merchant]]]])
      .where(transactions: { result: 'success' })
      .where(merchants: { id: id })  #second id is the id of the merchant that's getting called out
      .group(:id)
      .order(Arel.sql('COUNT(transactions.id) DESC'))
      .limit(5)
  end

  def items_ready_to_ship
    Item.joins(:merchant, invoice_items: [:invoice])
      .where.not(invoice_items: {status: "shipped"})
      .where(merchants: { id: id })
      .select("items.name as item_name,
              invoices.id as invoice_id,
              invoices.created_at as invoice_created_at")
      .order("invoice_created_at")
  end
  #
  # def invoice_for_item_ready_to_ship
  #   Invoice.joins(invoice_items: [item: [:merchant]]
  #     ).where(merchants: { id: id }
  #
  #     ).joins(:invoice_items)
  #      .where.not("invoice_items.status = shipped")
  # end
end