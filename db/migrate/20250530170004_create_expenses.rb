class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.references :politician, null: false, foreign_key: true
      t.datetime :issue_date
      t.string :supplier_name
      t.string :document_url
      t.decimal :amount, precision: 10, scale: 2
      t.string :description
      t.integer :document_kind, default: 0

      t.timestamps
    end
  end
end
