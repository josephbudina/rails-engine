class Api::V1::Merchants::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find_by!(id: params[:id])
    render json: ItemSerializer.new(merchant.items)
  end
end