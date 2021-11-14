require 'rails_helper'

RSpec.describe do
  before :each do
    @merchant1 = Merchant.create!(name: "Jimmy Pesto")
    @merchant2 = Merchant.create!(name: "Linda Belcher")
    @discount1 = @merchant1.bulk_discounts.create!(discount: 10.00, quantity_threshold: 10)
    @discount2 = @merchant2.bulk_discounts.create!(discount: 15.00, quantity_threshold: 20)
  end

  it "can edit a merchant's discount" do
    visit "/merchants/#{@merchant2.id}/discounts/#{@discount2.id}"
    save_and_open_page
    expect(page).to have_content("Quantity Threshold: 20")

    click_link "Update Discount"

    fill_in(:quantity_threshold, with: 35)
    click_button "Update Discount"

    expect(current_path).to eq("/merchants/#{@merchant2.id}/discounts/#{@discount2.id}")
    expect(page).to have_content("Quantity Threshold: 35")
  end
end
