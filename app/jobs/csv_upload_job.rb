class CsvUploadJob < ApplicationJob
  queue_as :default

  def perform(file_path, upload_id)
    upload = CsvUpload.find(upload_id)
    upload.update!(status: :processing)

    csv_file = File.open(file_path)

    total_relevant_rows = count_state_lines(csv_file, upload.state)
    upload.update!(total_rows: total_relevant_rows)

    csv_file.rewind

    processed = 0

    result = CreatePoliticiansExpenses.new.call(
      csv_file:,
      state: upload.state,
      batch_size: 200,
      on_progress: ->(count) {
        Rails.logger.info("Processed #{count} rows")
        processed += count
        upload.update!(processed_rows: processed)
      })

    if result.success?
      upload.update!(status: :done)
    else
      upload.update!(status: :failed, error_message: result.failure[:message])
    end
  ensure
    csv_file.close if csv_file
    File.delete(file_path) if File.exist?(file_path)
  end

  private

  def count_state_lines(csv_file, state)
    count = 0
    CSV.foreach(csv_file.path, headers: true, col_sep: ";", encoding: "bom|utf-8") do |row|
      count += 1 if row["sgUF"] == state
    end
    count
  end
end
