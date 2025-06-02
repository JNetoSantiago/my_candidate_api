class CreateCsvUploads < ActiveRecord::Migration[8.0]
  def change
    create_table :csv_uploads do |t|
      t.string :upload_id, null: false, index: { unique: true }
      t.integer :status, default: 0
      t.integer :total_rows
      t.integer :processed_rows, default: 0
      t.string :state
      t.text :error_message

      t.timestamps
    end
  end
end
