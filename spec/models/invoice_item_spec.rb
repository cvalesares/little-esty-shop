require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe 'methods' do
    it 'returns the total expected revenue from a given invoice' do
      customer = Customer.create!(first_name: 'Bob', last_name: 'Dylan')
      merchant = Merchant.create!(name: 'Jen')
      invoice = Invoice.create!(customer_id: customer.id, status: 'completed')
      item1 = Item.create!(name: 'Pumpkin', description: 'Orange', unit_price: 3, merchant_id: merchant.id)
      item2 = Item.create!(name: 'Pillow', description: 'Soft', unit_price: 20, merchant_id: merchant.id)
      invoice_item = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice.id, quantity: 10, unit_price: 30, status: 'shipped')
      invoice_item = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice.id, quantity: 2, unit_price: 40, status: 'shipped')

      expect(InvoiceItem.total_revenue(invoice)).to eq(70)
    end

    it 'can find the top discount' do
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

      expect(invoice_item_1.top_discount).to eq(0.5)
    end

    it 'can find by invoice id' do
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

      expect(InvoiceItem.find_by_invoice_id(invoice_1.id)).to eq(invoice_item_1)
    end

    it 'can find discounted revenue' do
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

      expect(invoice_item_1.discounted_revenue).to eq(25.0)
    end

    it "return no discounts if applicable discount doesn't exist" do
      merchant = Merchant.create(name: "Bob's Burger")
      item_1 = merchant.items.create(name: 'Burger', description: 'its on a string', unit_price: 1000)
      item_2 = merchant.items.create(name: 'Shake', description: 'dried grape', unit_price: 100)
      customer = Customer.create(first_name: 'Teddy', last_name: 'Lastname')
      invoice_1 = customer.invoices.create(status: 2)
      invoice_2 = customer.invoices.create(status: 2)
      invoice_item_1 = invoice_1.invoice_items.create!(item_id: item_1.id, quantity: 50, unit_price: 1, status: 1)
      invoice_item_2 = invoice_1.invoice_items.create!(item_id: item_2.id, quantity: 50, unit_price: 2, status: 1)
      discount1 = merchant.bulk_discounts.create!(discount: 10.00, quantity_threshold: 100)
      discount2 = merchant.bulk_discounts.create!(discount: 50.00, quantity_threshold: 150)

      expect(invoice_item_1.discounted_revenue).to eq(50)
      expect(invoice_item_2.discounted_revenue).to eq(100)
    end
  end
end
