require 'rails_helper'

RSpec.describe "Merchant Bulk Discount Show Page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Jimmy Pesto")
    @merchant2 = Merchant.create!(name: "Linda Belcher")
    @discount1 = @merchant1.bulk_discounts.create!(discount: 10.00, quantity_threshold: 10)
    @discount2 = @merchant2.bulk_discounts.create!(discount: 15.00, quantity_threshold: 20)
  end

  it "shows a discount and its attributes" do
    visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}"

    expect(page).to have_content(@discount1.discount)
    expect(page).to have_content(@discount1.quantity_threshold)
  end

  it "can update an existing discount" do
    visit "/merchants/#{@merchant1.id}/discounts/#{@discount1.id}"

    click_link "Update Discount"
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@discount1.id}/edit")
  end
end
