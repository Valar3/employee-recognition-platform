class OnlineCode < ApplicationRecord
  belongs_to :reward

  def generate_online_code(length)
    characters = (0..9).to_a
    code = Array.new(length) { characters.sample }.join
  end
  
end
