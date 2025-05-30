class Politician < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :external_id, presence: true, uniqueness: true
  validates :state, presence: true, inclusion: { in: %w[AC AL AP AM BA CE DF ES GO MA MT MS MG PA PB PR PE PI RJ RN RS RO RR SC SP SE TO] }
  validates :party, presence: true
  validates :cpf, format: { with: /\A\d{11}\z/, message: "deve ter 11 dígitos" }, allow_blank: true
  validates :photo_url, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_blank: true

  # Associations
  has_many :expenses, dependent: :destroy
end
