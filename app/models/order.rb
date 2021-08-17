class Order < ApplicationRecord
  enum status: { pending: 0, in_progress: 1, completed: 2 }

  after_create :check_status

  validate :update_status, on: :update

  private

  def check_status
    self.pending! unless self.pending?
  end

  def update_status
    if Order.find(self.id).in_progress? && self.pending?
      errors.add(:base, message: "Não é possível voltar order em progresso novamente para pendente!")
    end

    if Order.find(self.id).completed?
      errors.add(:base, message: "Não é possível alterar uma ordem já completa!")
    end

    if Order.find(self.id).pending? && self.completed?
      errors.add(:base, message: "Não é possível pular de pendente direto para completa!")
    end
  end
end
