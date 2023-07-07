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
  end

  context 'when we have a reward with the same title' do
    let!(:reward) { create(:reward, title: 'title') }
    let(:file) { Rails.root.join('spec/fixtures/files/rewards.csv') }

    it 'updates the reward' do
      expect { csv }.to change(Reward, :count).by(2)
      expect(reward.reload.description).to eq('description')
    end
  end
end
