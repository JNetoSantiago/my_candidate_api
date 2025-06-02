class CsvUpload < ApplicationRecord
  enum :status, queued: 0, processing: 1, done: 2, failed: 3

  validates :upload_id, presence: true, uniqueness: true
end
