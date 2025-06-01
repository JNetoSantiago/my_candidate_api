class ExpenseSerializer
  include JSONAPI::Serializer

  attributes :description, :amount, :document_url, :issue_date, :document_kind, :supplier_name

  attribute :amount do |expense|
    expense.amount.to_f / 100
  end
end
