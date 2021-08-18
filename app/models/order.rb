class Order < ApplicationRecord

  enum status: { pending: 0, in_progress: 1, completed: 2 }

  validates :product_name, presence: { message: "Forneça um nome" }
  validates :price, presence: { message: "Forneça um preço" }
  validates :price, numericality: { greater_than: 0 }

  after_create :check_status

  after_create :set_order_number

  validate :update_status, on: :update

  private

  def check_status
    self.pending! unless self.pending?
  end

  def set_order_number
    setting = if OrderSetting.first.nil?
                OrderSetting.create(last_number: 0)
              else
                OrderSetting.first
              end
    self.order_number = OrderSetting.first.last_number + 1
    self.save
    setting.update!(last_number: self.order_number)
  end

  def update_status
    if Order.find(self.id).in_progress? && self.pending?
      errors.add(:base, message: 'Não é possível voltar order em progresso novamente para pendente!')
    end

    if Order.find(self.id).completed? && !self.completed?
      errors.add(:base, message: 'Não é possível alterar uma ordem já completa!')
    end

    if Order.find(self.id).pending? && self.completed?
      errors.add(:base, message: 'Não é possível pular de pendente direto para completa!')
    end
  end
end
