class ExpenseSerializer
  include JSONAPI::Serializer

  attributes :description, :amount, :document_url, :issue_date, :document_kind, :supplier_name
end