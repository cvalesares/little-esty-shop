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

# Merchant Bulk Discount Edit
#
# As a merchant
# When I visit my bulk discount show page
# Then I see a link to edit the bulk discount
# When I click this link
# Then I am taken to a new page with a form to edit the discount
# And I see that the discounts current attributes are pre-poluated in the form
# When I change any/all of the information and click submit
# Then I am redirected to the bulk discount's show page
# And I see that the discount's attributes have been updated
