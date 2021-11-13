require 'rails_helper'

RSpec.describe 'Merchant Bulk Index' do
  before :each do
    @merchant1 = Merchant.create!(name: "Jimmy Pesto")
    @merchant2 = Merchant.create!(name: "Linda Belcher")
    @discount1 = @merchant1.bulk_discounts.create!(discount: 10.00, quantity_threshold: 10)
    @discount2 = @merchant2.bulk_discounts.create!(discount: 15.00, quantity_threshold: 20)
  end

  it "shows all of a merchant's discounts" do
    visit "/merchants/#{@merchant1.id}/discounts"

    expect(page).to have_content(@discount1.discount)
    expect(page).to have_content(@discount1.quantity_threshold)
    expect(page).to_not have_content(@discount2.discount)
    expect(page).to_not have_content(@discount2.quantity_threshold)

    within "#id-#{@discount1.id}" do
      click_link "Discount Details"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount1.id}")
    end
  end
end
