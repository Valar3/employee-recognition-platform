require 'rails_helper'
RSpec.describe ImportCsvService do
  subject(:csv) do
    described_class.new.call(file)
  end

  let!(:category) { create(:category) }

  describe '.call' do
    let(:file) { Rails.root.join('spec/fixtures/files/rewards.csv') }

    it 'imports a csv file' do
      expect { csv }.to change(Reward, :count).by(3)
    end

    it 'checks if the delivery method is imported correctly' do
      csv
      expect(Reward.first.delivery_method).to eq('post_delivery')
    end
  end

  context 'when we have a reward with the same title' do
    let!(:reward) { create(:reward, title: 'Title') }
    let(:file) { Rails.root.join('spec/fixtures/files/rewards.csv') }

    it 'updates the reward' do
      expect { csv }.to change(Reward, :count).by(2)
      expect(reward.reload.description).to eq('Description')
    end
  end
end
