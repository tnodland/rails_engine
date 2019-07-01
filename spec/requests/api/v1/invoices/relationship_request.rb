require 'rails_helper'

RSpec.describe  "invoice relationship requests" do
  it "can get transactions" do
    invoice = create(:invoice)
    create_list(:transaction, 3, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body, symbolize_names: true)

    expect(transactions).to be_a(Hash)
    expect(transactions).to have_key(:data)
    expect(transactions[:data]).to be_a(Array)
    expect(transactions[:data].count).to eq(3)
  end
end
