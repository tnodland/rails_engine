require 'rails_helper'

RSpec.describe "invoice API" do
  it "can get all invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body, symbolize_names: true)

    expect(invoices).to be_a(Hash)
    expect(invoices).to have_key(:data)
    expect(invoices[:data]).to be_a(Array)
    expect(invoices[:data].count).to eq(3)
  end
end
