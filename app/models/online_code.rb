class OnlineCode < ApplicationRecord
  belongs_to :reward
  validates :code, presence: true, uniqueness: true
end
