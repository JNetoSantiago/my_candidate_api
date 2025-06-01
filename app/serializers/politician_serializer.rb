class PoliticianSerializer
  include JSONAPI::Serializer

  has_many :expenses

  attributes :name, :cpf, :external_id, :state, :party, :photo_url, :politician_image_url

  attribute :politician_image_url do |politician|
    "http://www.camara.leg.br/internet/deputado/bandep/#{politician.external_id}.jpg"
  end
end
