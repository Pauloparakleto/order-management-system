require 'rails_helper'

RSpec.describe "Orders", type: :request do
  it 'gets index' do
    FactoryBot.create_list(:order, 10)
    get orders_path
    expect(response).to have_http_status(:ok)
  end

  it 'create' do
    post orders_path, params: { order: { product_name: "Whatever", price: 999.99 } }
    expect(response).to have_http_status(:found)
  end

  it 'show' do
    order = FactoryBot.create(:order)
    get order_path(order)
    expect(response).to have_http_status(:ok)
  end
end