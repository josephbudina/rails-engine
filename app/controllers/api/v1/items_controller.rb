class Api::V1::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find_by(id: params[:merchant_id])

    if @merchant
      render json: ItemSerializer.new(@merchant.items)
    else
      not_found
    end
  end
end