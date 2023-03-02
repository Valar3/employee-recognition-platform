require 'rails_helper'

RSpec.describe Reward, type: :model do
  before do
    create(:reward)
  end

  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_numericality_of(:price), message: 'is not a number' }
end
