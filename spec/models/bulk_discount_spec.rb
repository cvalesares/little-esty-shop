require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
  end

  describe 'methods' do
    it 'can find a discount by merchant id' do
      merchant = Merchant.create(name: "Bob's Burger")
      item_1 = merchant.items.create(name: 'Burger', description: 'its on a string', unit_price: 1000)
      item_2 = merchant.items.create(name: 'Shake', description: 'dried grape', unit_price: 100)
      customer = Customer.create(first_name: 'Teddy', last_name: 'Lastname')
      invoice_1 = customer.invoices.create(status: 2)
      invoice_2 = customer.invoices.create(status: 2)
      invoice_item_1 = invoice_1.invoice_items.create!(item_id: item_1.id, quantity: 50, unit_price: 1, status: 1)
      invoice_item_2 = invoice_1.invoice_items.create!(item_id: item_2.id, quantity: 50, unit_price: 2, status: 1)
      discount1 = merchant.bulk_discounts.create!(discount: 10.00, quantity_threshold: 10)
      discount2 = merchant.bulk_discounts.create!(discount: 50.00, quantity_threshold: 20)

      expect(BulkDiscount.find_by_merchant_id(merchant.id)).to eq(discount1)
    end
  end
end
