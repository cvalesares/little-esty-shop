require 'rails_helper'

RSpec.describe "create discount" do
  before :each do
    @merchant1 = Merchant.create!(name: "Jimmy Pesto")
  end

  it "can create a new bulk discount" do
    visit "/merchants/#{@merchant1.id}/discounts/new"

    fill_in(:discount, with: 25.00)
    fill_in(:quantity_threshold, with: 35)
    click_button("Create Bulk Discount")

    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts")
    
    expect(page).to have_content("Discount: 25.0%")
  end
end
