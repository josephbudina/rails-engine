class Api::V1::MerchantsController < ApplicationController
before_action :set_page, only: [:index]

  def index
    if params[:per_page]
      @merchants = Merchant.limit(params[:per_page].to_i).offset((@page.to_i - 1) * 20)
      render json: MerchantSerializer.new(@merchants)
    else params[:per_page].nil?
      @merchants = Merchant.limit(20).offset((@page.to_i - 1) * 20)
      render json: MerchantSerializer.new(@merchants)
    end
  end

  def show
    @merchant = Merchant.find_by!(id: params[:id])
    render json: MerchantSerializer.new(@merchant)
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