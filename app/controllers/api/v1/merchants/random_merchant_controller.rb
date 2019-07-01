class Api::V1::Merchants::RandomMerchantController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.order("RANDOM()").limit(1))
  end
end
