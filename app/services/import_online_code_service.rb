require 'csv'

class ImportOnlineCodeService
  def call(file)
    opened_file = File.open(file)
    options = { headers: true, col_sep: ';' }
    CSV.foreach(opened_file, **options) do |row|
      online_code = OnlineCode.find_or_initialize_by(code: row['Code'])
      online_code.used = row['Used']
      reward_id = row['Reward']
      reward = Reward.includes(:online_codes).find_by(id: reward_id)

      if reward
        online_code.reward = reward
      else
        Rails.logger.debug { "Warning: Reward with ID #{reward_id} not found in the database." }
      end

      online_code.save!
    end
  rescue StandardError => e
    Rails.logger.error { "Error during online code import: #{e.message}" }
    Rails.logger.error { e.backtrace.join("\n") }
  end
end
