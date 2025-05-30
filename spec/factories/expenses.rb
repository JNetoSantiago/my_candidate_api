FactoryBot.define do
  factory :expense do
    association :politician

    issue_date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    supplier_name { Faker::Company.name }
    document_url { Faker::Internet.url(host: 'camara.leg.br') }
    amount { Faker::Commerce.price(range: 50.0..1000.0) }
    description { Faker::Commerce.department }
    document_kind { 0 }
  end
end
