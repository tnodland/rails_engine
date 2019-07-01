require 'rails_helper'

RSpec.describe "customer API" do
  it "can get all customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body, symbolize_names: true)

    expect(customers).to be_a(Hash)
    expect(customers).to have_key(:data)
    expect(customers[:data]).to be_a(Array)
    expect(customers[:data].count).to eq(3)
  end
end
