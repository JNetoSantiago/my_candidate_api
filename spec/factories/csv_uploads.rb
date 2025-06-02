FactoryBot.define do
  factory :csv_upload do
    upload_id { SecureRandom.uuid }
    state { "PI" }
    status { :queued }
    total_rows { 0 }
    processed_rows { 0 }
    error_message { nil }
  end
end
