require "dry/monads"

class DashboardStats
  include Dry::Monads[:result]

  def call
    total_politicians = Politician.count
    total_expenses = Expense.count

    max_expense = Expense
      .includes(:politician)
      .order(amount: :desc)
      .limit(1)
      .first

    total_amount_in_cents = Expense.sum(:amount)
    total_amount = format_currency(cents_to_reais(total_amount_in_cents))

    result = {
      total_politicians: total_politicians,
      total_expenses: total_expenses,
      max_expense: max_expense && {
        amount: format_currency(cents_to_reais(max_expense.amount)),
        description: max_expense.description,
        politician: {
          name: max_expense.politician.name,
          party: max_expense.politician.party,
          state: max_expense.politician.state
        }
      },
      total_amount: total_amount
    }

    Success(result)
  rescue => e
    Failure(e.message)
  end

  private

  def cents_to_reais(value)
    (value.to_f / 100).round(2)
  end

  def format_currency(value)
    ActionController::Base.helpers.number_to_currency(value, unit: "R$ ", separator: ",", delimiter: ".")
  end
end
