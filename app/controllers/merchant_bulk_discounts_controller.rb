class MerchantBulkDiscountsController < ApplicationController

  def index
    # @discounts = BulkDiscount.find(params[:merchant_id])
    @discounts = BulkDiscount.where(merchant_id: params[:merchant_id])
  end

  def show
  end 

end
