require 'rails_helper'

RSpec.describe "Merchants API" do
  it "can send all merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a(Hash)
    expect(merchants).to have_key(:data)
    expect(merchants[:data]).to be_a(Array)
    expect(merchants[:data].count).to eq(3)
  end

  it "can send a single merchant based on search terms" do
    merchant = create(:merchant, name: "Trevor Nodland")

    get '/api/v1/merchants/find?name=Trevor Nodland'

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant).to be_a(Hash)
    expect(merchant).to have_key(:data)
  end

  it "can send a collection of merchants based on search terms" do
    merchant1 = create(:merchant, name: "Trevor Nodland")
    merchant2 = create(:merchant, name: "Trevor Nodland")

    get '/api/v1/merchants/find_all?name=Trevor Nodland'

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant).to be_a(Hash)
    expect(merchant).to have_key(:data)
  end

  it "can get a random merchant" do
    merchant = create(:merchant, name: "Trevor Nodland")

    get '/api/v1/merchants/random'

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant).to be_a(Hash)
    expect(merchant).to have_key(:data)
  end
end
