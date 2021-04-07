class Api::V1::Items::FindAllController < ApplicationController
  def index
    @item = Item.where(nil)

    find_all_params(params).each do |key, value|
      @item = @item.public_send("find_by_#{key}", value)
    end

    if @item.present?
      render json: ItemSerializer.new(@item)
    else
      render json: {data: [], error: "error"}, status: 400
    end
  end

  private

  def find_all_params(params)
    params.permit(:name, :min_price, :max_price)
  end
end