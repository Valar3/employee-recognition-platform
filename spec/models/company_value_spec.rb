require 'rails_helper'

RSpec.describe CompanyValue, type: :model do
  before do
    create(:company_value)
  end

  it { is_expected.to validate_uniqueness_of(:title) }
  it { is_expected.to validate_presence_of(:title) }
end
