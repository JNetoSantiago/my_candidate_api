require "rails_helper"
require "csv"
require "tempfile"

RSpec.describe CsvUploadJob, type: :job do
  let(:state)  { "PI"                                                    }
  let(:upload) { create(:csv_upload, status: :queued, state: state)      }

  let(:csv_file) do
    Tempfile.new([ "upload", ".csv" ]).tap do |file|
      file.write("sgUF;descricao\n")
      file.write("PI;PASSAGEM AÉREA\n")
      file.write("SP;PASSAGEM AÉREA\n")
      file.write("PI;HOSPEDAGEM\n")
      file.rewind
    end
  end

  after { csv_file.close && csv_file.unlink }

  context "when processing is successful" do
    let(:fake_service) do
      instance_double(CreatePoliticiansExpenses, call: Dry::Monads::Success())
    end

    before do
      allow(CreatePoliticiansExpenses).to receive(:new).and_return(fake_service)
    end

    it "processes the CSV, updates rows and sets status to done" do
      expect {
        described_class.perform_now(csv_file.path, upload.id)
      }.to change { upload.reload.status }.from("queued").to("done")

      expect(upload.reload.total_rows).to eq(2)
      expect(upload.reload.processed_rows).to eq(0)
    end
  end

  context "when processing fails" do
    let(:fake_service) do
      instance_double(CreatePoliticiansExpenses, call: Dry::Monads::Failure({ message: "Erro no parse" }))
    end

    before do
      allow(CreatePoliticiansExpenses).to receive(:new).and_return(fake_service)
    end

    it "sets status to failed and saves the error message" do
      described_class.perform_now(csv_file.path, upload.id)

      upload.reload
      expect(upload.status).to eq("failed")
      expect(upload.error_message).to eq("Erro no parse")
    end
  end

  context "when on_progress callback is triggered" do
    it "updates processed_rows as expected" do
      fake_service = double
      allow(fake_service).to receive(:call) do |args|
        args[:on_progress].call(1)
        args[:on_progress].call(1)
        Dry::Monads::Success()
      end

      allow(CreatePoliticiansExpenses).to receive(:new).and_return(fake_service)

      described_class.perform_now(csv_file.path, upload.id)

      upload.reload
      expect(upload.processed_rows).to eq(2)
      expect(upload.status).to eq("done")
    end
  end
end
