require 'rails_helper'

RSpec.describe "Orders", type: :request do
  it 'gets index' do
    FactoryBot.create_list(:order, 10)
    get orders_path
    expect(response).to have_http_status(:ok)
  end
end