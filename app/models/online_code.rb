class OnlineCode < ApplicationRecord
  belongs_to :reward

  attr_accessor :generated_code

  before_create :generate_online_code

  private

  def generate_online_code
    self.code = SecureRandom.alphanumeric(6).upcase
  end
end
