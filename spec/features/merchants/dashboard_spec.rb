require "rails_helper"

RSpec.describe "Merchant's dashboard", type: :feature do
  describe "as merchant" do
    before(:each) do
      @merchant = Merchant.create(name: "Friendly Traveling Merchant")

      @item = @merchant.items.create(name: 'YoYo', description: 'its on a string')

      @customer_1 = Customer.create(first_name: 'George', last_name: 'Washington')
      @customer_2 = Customer.create(first_name: 'John', last_name: 'Adams')
      @customer_3 = Customer.create(first_name: 'Thomas', last_name: 'Jefferson')
      @customer_4 = Customer.create(first_name: 'James', last_name: 'Madison')
      @customer_5 = Customer.create(first_name: 'James', last_name: 'Monroe')
      @customer_6 = Customer.create(first_name: 'John Quincy', last_name: 'Adams')

      @invoice_1 = @customer_1.invoices.create(status: 'Completed')
      @invoice_2 = @customer_2.invoices.create(status: 'Completed')
      @invoice_3 = @customer_3.invoices.create(status: 'Completed')
      @invoice_4 = @customer_4.invoices.create(status: 'Completed')
      @invoice_5 = @customer_5.invoices.create(status: 'Completed')
      @invoice_6 = @customer_6.invoices.create(status: 'Completed')

      @invoice_item_1 = @invoice_1.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')
      @invoice_item_2 = @invoice_2.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')
      @invoice_item_3 = @invoice_3.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')
      @invoice_item_4 = @invoice_4.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')
      @invoice_item_5 = @invoice_5.invoice_items.create(item_id: @item.id, quantity: 1, unit_price: 1000, status: 'shipped')

      @transaction_1 = @invoice_1.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_2 = @invoice_1.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_3 = @invoice_2.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_4 = @invoice_2.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_5 = @invoice_3.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_6 = @invoice_4.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_7 = @invoice_4.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_8 = @invoice_5.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_9 = @invoice_5.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_10 = @invoice_5.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'success')
      @transaction_11 = @invoice_6.transactions.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2012-03-27', result: 'failed')

      visit "/merchants/#{@merchant.id}/dashboard"
    end

    it "I see the name of my merchant" do
      expect(page).to have_content(@merchant.name)
    end

    it "I see link to merchant items index" do
      click_link "My Items"
      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    end

    it "I see a link to merchant invoice index" do
      click_link "My Invoices"
      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    end

    it "I see the 5 customer names with the most successful transactions" do
      visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_content 'Favorite Customers'
      expect(page).to_not have_content @customer_6.first_name
      expect(@customer_5.last_name).to appear_before(@customer_1.last_name)
      expect(@customer_5.last_name).to appear_before(@customer_2.last_name)
      expect(@customer_5.last_name).to appear_before(@customer_4.last_name)
      expect(@customer_1.last_name).to appear_before(@customer_3.last_name)
      expect(@customer_2.last_name).to appear_before(@customer_3.last_name)
      expect(@customer_4.last_name).to appear_before(@customer_3.last_name)
    end

    it 'I also see each customers number of succesful transactions' do
      expect(page).to have_content "#{@customer_5.last_name} - 3 purchases"
      expect(page).to have_content "#{@customer_1.last_name} - 2 purchases"
      expect(page).to have_content "#{@customer_2.last_name} - 2 purchases"
      expect(page).to have_content "#{@customer_4.last_name} - 2 purchases"
      expect(page).to have_content "#{@customer_3.last_name} - 1 purchases"
    end
  end
end
