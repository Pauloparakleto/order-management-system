require 'rails_helper'

def create_valid_order
  Order.create(product_name: "PS3", price: 687.98)
end

RSpec.describe Order, type: :model do

  context "when increment" do
    it '1' do
      order = create_valid_order
      expect(order.order_number).to eq(1)
    end

    it '2' do
      create_valid_order
      order_second = create_valid_order
      expect(order_second.order_number).to eq(2)
    end
  end

  context "when create" do
    it 'valid' do
      order = Order.create(product_name: "PS3", price: 234.56, order_number: 1)
      expect(order).to be_truthy
    end

    it 'has name' do
      order = Order.create(product_name: "PS3")
      expect(order.product_name).to eq("PS3")
    end

    it 'has price' do
      order = Order.create(product_name: "PS3", price: 897.98)
      expect(order.price).to eq(897.98)
    end

    it 'has negative price' do
      order = Order.create(product_name: "PS5", price: -11.98)
      expect(order.errors.any?).to eq(true)
      expect(order.errors.full_messages).to eq(["Price must be greater than 0"])
    end

    it 'has negative price update' do
      order = Order.create(product_name: "PS5", price: 11.98)
      order.update(price: -11.98)
      expect(order.errors.any?).to eq(true)
      expect(order.errors.full_messages).to eq(["Price must be greater than 0"])
    end

    it 'has price string' do
      order = Order.create(product_name: "PS5", price: 'abc')
      expect(order.errors.any?).to eq(true)
      expect(order.errors.full_messages).to eq(["Price is not a number"])
    end

    it 'has price string update' do
      order = Order.create(product_name: "PS5", price: 11.98)
      order.update(price: 'cda')
      expect(order.errors.any?).to eq(true)
      expect(order.errors.full_messages).to eq(["Price is not a number"])
    end

    it 'has no price' do
      order = Order.create(product_name: "PS3")
      expect(order.errors.any?).to eq(true)
      expect(order.errors.full_messages.first).to eq("Price Forneça um preço")
    end

    it 'has no product name' do
      order = Order.create(price: 9.99)
      expect(order.errors.any?).to eq(true)
      expect(order.errors.full_messages).to eq(["Product name Forneça um nome"])
    end

    it 'status pending' do
      order = Order.create(product_name: "PS3", price: 234.56, order_number: 1, status: :pending)
      expect(order.status).to eq("pending")
    end

    it 'status pending as default' do
      order = Order.create(product_name: "PS3", price: 234.56, order_number: 1)
      expect(order.status).to eq("pending")
    end

    it 'status completed' do
      order = Order.create(product_name: "PS3", price: 66.89, order_number: 1, status: :completed)
      expect(order.status).to eq("pending")
    end

    it 'status in progress' do
      order = Order.create(product_name: "PS3", price: 234.56, order_number: 1, status: :in_progress)
      expect(order.status).to eq("pending")
    end
  end

  context "when update" do
    it "pending to in_progress" do
      order = Order.create(product_name: "PS3", price: 234.56, order_number: 1)
      order.in_progress!
      expect(order.reload.status).to eq("in_progress")
    end

    it 'in progress to completed' do
      order = Order.create(product_name: "PS3", price: 234.56, order_number: 1)
      order.in_progress!
      order.completed!
      expect(order.status).to eq("completed")
    end

    it 'in progress backward to pending' do
      order = Order.create(product_name: "PS3", price: 234.56, order_number: 1)
      order.in_progress!
      order.update(status: :pending)
      expect(order.errors.any?).to eq(true)
      expect(order.errors[:base].pluck(:message)).to eq(["Não é possível voltar order em progresso novamente para pendente!"])
    end

    it 'completed backward to pending' do
      order = Order.create(product_name: "PS3", price: 234.56, order_number: 1)
      order.in_progress!
      order.completed!
      order.update(status: :pending)
      expect(order.errors.any?).to eq(true)
      expect(order.errors[:base].pluck(:message)).to eq(["Não é possível alterar uma ordem já completa!"])
    end

    it 'completed backward to in progress' do
      order = Order.create(product_name: "PS3", price: 234.56, order_number: 1)
      order.in_progress!
      order.completed!
      order.update(status: :in_progress)
      expect(order.errors.any?).to eq(true)
      expect(order.errors[:base].pluck(:message)).to eq(["Não é possível alterar uma ordem já completa!"])
    end

    it 'pending to completed' do
      order = Order.create(product_name: "PS3", price: 234.56, order_number: 1)
      order.update(status: :completed)
      expect(order.errors.any?).to eq(true)
      expect(order.errors[:base].pluck(:message)).to eq(["Não é possível pular de pendente direto para completa!"])
    end
  end
end
