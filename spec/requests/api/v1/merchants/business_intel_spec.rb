require 'rails_helper'

RSpec.describe "Merchant BI API" do
  before :each do
    @customer = create(:customer)
    @customer2 = create(:customer)
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    item1 = create(:item, merchant: @merchant1)
    item2 = create(:item, merchant: @merchant2)
    item3 = create(:item, merchant: @merchant3)
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
    create(:invoice_item, item: item1, invoice: invoice1)
    create(:invoice_item, item: item2, invoice: invoice2)
    create(:invoice_item, item: item3, invoice: invoice3)
    create(:invoice_item, item: item3, invoice: invoice4)
  end

  context "revenue" do
    it "can get top merchants by total revenue" do
      get "/api/v1/merchants/most_revenue?quantity=2"

      merchants = JSON.parse(response.body)

      expect(merchants["data"].count).to eq(2)
      expect(merchants["data"][0]["attributes"]["id"]).to eq(@merchant3.id)
      expect(merchants["data"][1]["attributes"]["id"]).to eq(@merchant1.id)
    end

    it "can get revenue for a single merchant" do
      get "/api/v1/merchants/#{@merchant1.id}/revenue"

      merchant = JSON.parse(response.body)

      expect(merchant["data"]["attributes"]["revenue"]).to eq("1.20")
    end

    it "can get total revenue across all merhcants for a date" do
      date = Transaction.all.first.created_at

      get "/api/v1/merchants/revenue?date=#{date}"

      revenue = JSON.parse(response.body)

      expect(revenue["data"]["attributes"]["total_revenue"]).to eq("4.80")
    end

    it "can get revenue for a single merchant by date" do
      date = Transaction.all.first.created_at

      get "/api/v1/merchants/#{@merchant1.id}/revenue?date=#{date}"

      revenue = JSON.parse(response.body)

      expect(revenue["data"]["attributes"]["revenue"]).to eq("1.20")
    end
  end

  it "can get top merchants by items sold" do
    get "/api/v1/merchants/most_items?quantity=2"

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["attributes"]["id"]).to eq(@merchant3.id)
    expect(merchants["data"][1]["attributes"]["id"]).to eq(@merchant1.id)
  end

  it "can get a merchants' favorite customer" do
    get "/api/v1/merchants/#{@merchant1.id}/favorite_customer"

    json = JSON.parse(response.body)

    expect(json["data"]["attributes"]["id"]).to eq(@customer.id)
  end
end
