class Api::V1::Merchants::FindController < ApplicationController
  def show
    merchant = Merchant.find_one(params[:name])
    if merchant.nil?
      render json: {data: {}}
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end