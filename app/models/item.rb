class Item < ApplicationRecord
  has_many :invoice_items
  belongs_to :merchant

  def price
    unit_price/100.0
  end

  def change_status
    if status == "able"
      update(status: "unable")
    else
      update(status: "able")
    end
  end
end
