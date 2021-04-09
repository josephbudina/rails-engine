class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    if params[:quantity].present? && params[:quantity].to_i != 0
      merchant = Merchant.most_items(params[:quantity].to_i)
      render json: MostItemsSerializer.new(merchant)
    else
      render json: {data: {}, error: "error"}, status: 400
    end
  end
end