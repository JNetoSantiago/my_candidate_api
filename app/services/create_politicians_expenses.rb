require "csv"

class CreatePoliticiansExpenses
  include Dry::Monads[:result, :do]

  def call(csv_file:, state:, batch_size:)
    expenses_batch = []

    CSV.foreach(csv_file.path, headers: true, col_sep: ";", encoding: "bom|utf-8") do |row|
      next unless row["sgUF"] == state

      politician = yield politicians_exists(row)
      expense = yield build_expense(row, politician.id)

      expenses_batch << expense

      if expenses_batch.size >= batch_size
        yield flush_expenses_batch(expenses_batch)
      end
    end

    expenses_batch.clear

    Success(true)
  end

  private

  def politicians_exists(row)
    external_id = row["ideCadastro"].to_i
    politician = Politician.find_by(external_id: external_id)

    politician = Politician.create(
      external_id: external_id,
      name: row["txNomeParlamentar"],
      cpf: row["cpf"],
      party: row["sgPartido"],
      state: row["sgUF"]
    ) if politician.nil?

    Success(politician)
  rescue ActiveRecord::RecordInvalid => e
    Failure({ type: :invalid_record, message: e.message })
  end

  def build_expense(row, politician_id)
    issue_date = Date.parse(row["datEmissao"]) rescue nil

    original_amount = row["vlrLiquido"].to_d || 0.0
    amount = (original_amount * 100).to_i

    expense = Expense.new(
      politician_id: politician_id,
      issue_date:,
      supplier_name: row["txtFornecedor"],
      document_url: row["urlDocumento"],
      amount:,
      description: row["txtDescricao"]
    )

    return Failure({ type: :invalid_record, message: expense.errors.full_messages.join(", ") }) unless expense.valid?

    Success(expense)
  rescue StandardError => e
    Failure({ type: :unexpected_error, message: e.message })
  end

  def flush_expenses_batch(expenses_batch)
    Expense.import(expenses_batch, on_duplicate_key_ignore: true)

    expenses_batch.clear

    Success(true)
  rescue ActiveRecord::RecordInvalid => e
    Failure({ type: :import_error, message: e.message })
  rescue StandardError => e
    Failure({ type: :unexpected_error, message: e.message })
  end
end
