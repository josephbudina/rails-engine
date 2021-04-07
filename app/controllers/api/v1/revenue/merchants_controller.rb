class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity] && params[:quantity].to_i
      quantity = params[:quantity]
      merchant = Merchant.top_revenue(quantity)
      render json: MerchantNameRevenueSerializer.new(merchant)
    else
      render json: {data: {}, error: "error"}, status: 400
    end
  end

  def show
    merchant = Merchant.find_by!(id: params[:id])
    render json: MerchantRevenueSerializer.new(merchant)
  end 
end