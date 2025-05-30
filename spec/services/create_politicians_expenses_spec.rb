require 'rails_helper'

RSpec.describe CreatePoliticiansExpenses do
  let(:service)       { described_class.new                                             }
  let(:csv_file_path) { Rails.root.join('spec/fixtures/files/politicians_expenses.csv') }
  let(:csv_file)      { File.open(csv_file_path)                                        }

  describe '#call' do
    let(:result) { service.call(csv_file: csv_file, state: 'PI', batch_size: 2) }

    it 'returns success result' do
      expect(result).to be_success
    end

    it 'creates 2 politicians' do
      result
      expect(Politician.count).to eq(2)
    end

    it 'creates correct politician names' do
      result
      expect(Politician.pluck(:name)).to eq([ 'Julio Arcoverde', 'Fausto Pinato' ])
    end

    it 'creates 14 expenses' do
      result
      expect(Expense.count).to eq(14)
    end
  end
end
