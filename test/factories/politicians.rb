FactoryBot.define do
  factory :politician do
    name { "Jhon Doe" }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    external_id { Faker::Number.unique.number(digits: 5) }
    state { "PI" }
    party { "ABC" }
    photo_url { "http://www.camara.leg.br/internet/deputado/bandep/#{external_id}.jpg" }
  end
end
