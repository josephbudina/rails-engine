class Api::V1::ItemsController < ApplicationController
  before_action :set_page, only: [:index]
  def index
    if params[:per_page]
      @items = Item.limit(params[:per_page].to_i).offset((@page.to_i - 1) * 20)
      render json: ItemSerializer.new(@items)
    else params[:per_page].nil?
      @items = Item.limit(20).offset((@page.to_i - 1) * 20)
      render json: ItemSerializer.new(@items)
    end
  end

  def show
    @item = Item.find(params[:id])
    render json: ItemSerializer.new(@item)
  end

  private

  def set_page
    if params[:page].nil? || params[:page].to_i >= 1
      @page = params[:page] || 1
    else
      @page = 1
    end
  end
end