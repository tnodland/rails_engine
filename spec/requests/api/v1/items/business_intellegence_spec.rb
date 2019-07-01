require 'rails_helper'

RSpec.describe "items business intellegence" do
  before :each do
    @customer = create(:customer)
    @customer2 = create(:customer)
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant2)
    @item3 = create(:item, merchant: @merchant3)
    invoice1 = create(:invoice, customer: @customer, merchant: @merchant1)
    invoice2 = create(:invoice, customer: @customer, merchant: @merchant2)
    invoice3 = create(:invoice, customer: @customer, merchant: @merchant3)
    invoice4 = create(:invoice, customer: @customer, merchant: @merchant3)
    invoice5 = create(:invoice, customer: @customer, merchant: @merchant3)
    transaction1 = create(:transaction, invoice: invoice1)
    transaction2 = create(:transaction, invoice: invoice2)
    transaction3 = create(:transaction, invoice: invoice3)
    transaction4 = create(:transaction, invoice: invoice4)
    transaction5 = create(:transaction, invoice: invoice4, result: 0)
    create(:invoice_item, item: @item1, invoice: invoice1)
    create(:invoice_item, item: @item2, invoice: invoice2)
    create(:invoice_item, item: @item3, invoice: invoice3)
    create(:invoice_item, item: @item3, invoice: invoice4)
  end

  it "can return items by most revenue" do
    get "/api/v1/items/most_revenue?quantity=2"

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["attributes"]["id"]).to eq(@item3.id)
    expect(items["data"][1]["attributes"]["id"]).to eq(@item1.id)
  end

  it "can get the most sold items" do
    get "/api/v1/items/most_items?quantity=2"

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["attributes"]["id"]).to eq(@item3.id)
    expect(items["data"][1]["attributes"]["id"]).to eq(@item1.id)
  end

  it "can get the best day for an item" do
    get "/api/v1/items/#{@item1.id}/best_day"

    day = JSON.parse(response.body)
    date = @item1.created_at.to_date
  
    expect(day["data"]["attributes"]["best_day"]).to eq("#{date}")
  end
end
