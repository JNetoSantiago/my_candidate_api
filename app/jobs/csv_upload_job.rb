class CsvUploadJob < ApplicationJob
  STATE = "PI".freeze

  queue_as :default

  def perform(file_path)
    csv_file = File.open(file_path)

    CreatePoliticiansExpenses.new.call(csv_file:, state: STATE, batch_size: 200)
  ensure
    csv_file.close if csv_file
    File.delete(file_path) if File.exist?(file_path)
  end
end
