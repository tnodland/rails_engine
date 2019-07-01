class Api::V1::Items::ItemsSoldController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.most_items_sold(params[:quantity]))
  end

  def show
    render json: BestDaySerializer.new(Item.best_day(params[:id])[0])
  end
end
