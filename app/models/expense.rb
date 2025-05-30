class Expense < ApplicationRecord
  validates :description, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :politician
end
