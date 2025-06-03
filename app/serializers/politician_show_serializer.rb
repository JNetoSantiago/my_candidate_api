class PoliticianShowSerializer
  include JSONAPI::Serializer

  attributes :name, :cpf, :external_id, :state, :party, :photo_url, :politician_image_url, :expenses_total, :largest_expense

  has_many :expenses do |politician, params|
    params && params[:expenses] || politician.expenses
  end

  attribute :politician_image_url do |politician|
    "http://www.camara.leg.br/internet/deputado/bandep/#{politician.external_id}.jpg"
  end

  attribute :expenses_total do |politician|
    politician.expenses.sum(:amount).to_f / 100
  end

  attribute :largest_expense do |politician|
    maior = politician.expenses.order(amount: :desc).first
    maior ? ActiveSupport::NumberHelper.number_to_currency(maior.amount.to_f / 100, unit: "R$ ", separator: ",", delimiter: ".") : nil
  end
end
