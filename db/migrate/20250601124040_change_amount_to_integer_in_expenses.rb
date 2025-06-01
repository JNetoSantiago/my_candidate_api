class ChangeAmountToIntegerInExpenses < ActiveRecord::Migration[8.0]
  def change
    change_column :expenses, :amount, :integer
  end
end
