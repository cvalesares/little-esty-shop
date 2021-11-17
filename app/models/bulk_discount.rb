class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  def find_by_merchant_id(merchant_id)
    merchant = Merchant.find(merchant_id)
    id = merchant.bulk_discount_id
    BulkDiscount.find(id)
  end 
end
