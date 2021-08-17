require 'rails_helper'

RSpec.describe Order, type: :model do
  context "when create" do
    it 'valid' do
      order = Order.create(order_number: 1)
      expect(order).to be_truthy
    end

    it 'status pending' do
      order = Order.create(order_number: 1, status: :pending)
      expect(order.status).to eq("pending")
    end

    it 'status pending as default' do
      order = Order.create(order_number: 1)
      expect(order.status).to eq("pending")
    end

    it 'status completed' do
      order = Order.create(order_number: 1, status: :completed)
      expect(order.status).to eq("pending")
    end
  end

  context "when update" do
    it "pending to in_progress" do
      order = Order.create(order_number: 1)
      order.in_progress!
      expect(order.reload.status).to eq("in_progress")
    end

    it 'in progress to completed' do
      order = Order.create(order_number: 1)
      order.completed!
      expect(order.status).to eq("completed")
    end

    it 'in progress backward to pending' do
      order = Order.create(order_number: 1)
      order.in_progress!
      order.pending!
      expect(order.errors.any?).to eq(true)
      expect(order.errors[:base]).to eq(["Não é possível voltar order em progresso novamente para pendente!"])
    end
  end
end
