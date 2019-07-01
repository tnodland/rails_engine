class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end

  def show
    merchant = Merchant.find(params[:id])
    if params[:date]
      render json: RevenueSerializer.new(merchant.total_revenue_by_date(params["date"])[0])
    else
      render json: RevenueSerializer.new(merchant.total_revenue[0])
    end
  end
end
