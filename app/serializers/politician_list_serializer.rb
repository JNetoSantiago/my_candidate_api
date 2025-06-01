class PoliticianListSerializer
  include JSONAPI::Serializer

  attributes :name, :cpf, :external_id, :state, :party, :photo_url, :politician_image_url, :expenses_total

  attribute :politician_image_url do |politician|
    "http://www.camara.leg.br/internet/deputado/bandep/#{politician.external_id}.jpg"
  end

  attribute :expenses_total do |politician|
    politician.expenses.sum(:amount).to_f / 100
  end
end
