class Api::V1::Items::ItemsMerchantController < ApplicationController
  def index
    item = Item.find_by!(id: params[:id])
    @merchant = item.merchant
    render json: MerchantSerializer.new(@merchant)
  end
end