require 'rails_helper'

RSpec.describe Employee, type: :model do
  before do
    create(:employee)
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:surname) }
  it { is_expected.to validate_presence_of(:password) }
end
