class Api::V1::Revenue::ItemsController < ApplicationController
  def index
    if params[:quantity].present? && params[:quantity].to_i != 0
      item = Item.top_revenue(params[:quantity])
      render json: ItemRevenueSerializer.new(item)
    else
      render json: {data: {}, error: "error"}, status: 400  
    end
  end
end