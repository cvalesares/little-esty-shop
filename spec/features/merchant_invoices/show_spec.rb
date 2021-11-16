require "rails_helper"

RSpec.describe "merchant's invoice show page", type: :feature do
  describe "when I visit my merchant's invoice show page" do
    before(:each) do
      @merchant = Merchant.create(name: "Bob's Burger")

      @item_1 = @merchant.items.create(name: 'Burger', description: 'its on a string', unit_price: 1000)
      @item_2 = @merchant.items.create(name: 'Shake', description: 'dried grape', unit_price: 100)

      @customer = Customer.create(first_name: 'Teddy', last_name: 'Lastname')

      @invoice_1 = @customer.invoices.create(status: 2)
      @invoice_2 = @customer.invoices.create(status: 2)

      @invoice_item_1 = @invoice_1.invoice_items.create(item_id: @item_1.id, quantity: 20, unit_price: 1000, status: 1)
      @invoice_item_2 = @invoice_1.invoice_items.create(item_id: @item_2.id, quantity: 25, unit_price: 100, status: 1)

      @discount1 = @merchant.bulk_discounts.create!(discount: 10.00, quantity_threshold: 10)
      @discount2 = @merchant.bulk_discounts.create!(discount: 15.00, quantity_threshold: 20)


      visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"
    end

    it "I see invoice's id, status and created_at date" do
      save_and_open_page
      expect(page).to have_content("Invoice ID: #{@invoice_1.id}")
      expect(page).to_not have_content("Invoice ID: #{@invoice_2.id}")

      expect(page).to have_content("Invoice Status: #{@invoice_1.status}")
      expect(page).to have_content("Created At: #{@invoice_1.created_at.strftime("%A, %B %-d, %Y")}")
    end

    it "I see customer's first and last name" do
      expect(page).to have_content("Customer: #{@customer.first_name} #{@customer.last_name}")
    end

    it "I also see the invoice items attached to this invoice" do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@invoice_item_1.quantity)
      expect(page).to have_content(@invoice_item_1.unit_price)
      expect(page).to have_content(@invoice_item_1.status)
    end

    it "displays total revenue for the invoice" do
      expect(page).to have_content("Total Revenue: $22,500.00")
    end

    it "I can update the invoice item's status" do
      within "#id-#{@invoice_item_1.id}" do
        select "pending", from: "Status"
        click_button "Update Item Status"
        expect(page).to have_content "pending"
      end

      within "#id-#{@invoice_item_2.id}" do
        select "shipped", from: "Status"
        click_button "Update Item Status"
        expect(page).to have_content "shipped"
      end
    end

    it "shows the total revenue and discounted revenue" do
      visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content("Total Revenue: $22,500.00")
      expect(page).to have_content("Discounted Total Revenue: $19,125.00")
    end
  end
end


# Merchant Invoice Show Page: Total Revenue and Discounted Revenue
#
# As a merchant
# When I visit my merchant invoice show page
# Then I see the total revenue for my merchant from this invoice (not including discounts)
# And I see the total discounted revenue for my merchant from this invoice which includes bulk discounts in the calculation
