require 'rails_helper'

RSpec.describe "transaction API" do
  it "can get all transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body, symbolize_names: true)

    expect(transactions).to be_a(Hash)
    expect(transactions).to have_key(:data)
    expect(transactions[:data]).to be_a(Array)
    expect(transactions[:data].count).to eq(3)
  end
end
