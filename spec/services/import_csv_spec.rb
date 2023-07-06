require 'rails_helper'
RSpec.describe ImportCsvService do
  let!(:category) { create(:category) }
  subject(:csv) do

    ImportCsvService.new.call(file)

  end
describe '.call' do
  let(:file) { Rails.root.join('spec/fixtures/files/rewards.csv') }
  let(:reward) { create(:reward) }

  it 'imports a csv file' do
    expect { csv }.to change { Reward.count }.by(3)

    end
  end
end

