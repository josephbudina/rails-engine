class Api::V1::ItemsController < ApplicationController
  before_action :set_page, only: [:index]
  before_action :set_offset, only: [:index]
  before_action :set_merchant, only: [:create]
  before_action :set_merchant_item, only: [:show, :update, :destroy]

  def index 
      items = Item.limit(@per_page).offset((@page - 1) * @per_page)
      render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find_by!(id: params[:id])
    render json: ItemSerializer.new(item)
  end

  def create
    merchant = @merchant.items.create(item_params)
    render json: ItemSerializer.new(merchant), status: :created
  end

  def update
      item = Item.find(params[:id])
      item.update!(item_params)
      render json: ItemSerializer.new(item), status: :ok
  end

  def destroy
    Item.find(params[:id]).destroy
  end

  private

  def set_offset
    if params[:per_page].nil? || params[:per_page].to_i < 1
      @per_page = 20
    else
      @per_page = params[:per_page].to_i
    end
  end

  def set_page
    if params[:page].nil? || params[:page].to_i < 1
      @page = 1
    else
      @page = params[:page].to_i
    end
  end

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def set_merchant_item
    @item = @merchant.items.find_by!(id: params[:id]) if @merchant
  end
end