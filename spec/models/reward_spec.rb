require 'rails_helper'

RSpec.describe Reward, type: :model do
  before do
    create(:reward)
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_numericality_of(:price), message: 'is not a number' }
  it { is_expected.to validate_numericality_of(:price), greater_than_or_equal_to: 1, message: 'is a valid numer' }
  it { is_expected.to validate_numericality_of(:price), lesser_than: 1, message: 'is not a valid numer' }
end
