class MerchantBulkDiscountsController < ApplicationController

  def index
    # @discounts = BulkDiscount.find(params[:merchant_id])
    @discounts = BulkDiscount.where(merchant_id: params[:merchant_id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:discount_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    discount = BulkDiscount.create!(discount_params)
    @merchant = Merchant.find(params[:merchant_id])

    redirect_to "/merchants/#{@merchant.id}/discounts"
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:discount_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:discount_id])
    @discount.update(discount_params)

    redirect_to "/merchants/#{@merchant.id}/discounts/#{@discount.id}"
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:discount_id])
    @discount.destroy

    redirect_to "/merchants/#{@merchant.id}/discounts"
  end

  private
    def discount_params
      params.permit([:discount, :quantity_threshold, :merchant_id])
    end
end
