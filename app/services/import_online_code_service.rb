require 'csv'
  class ImportOnlineCodeService
    def call(file)
      opened_file = File.open(file)
      options = { headers: true, col_sep: ';' }
      CSV.foreach(opened_file, **options) do |row|
      current_row = row
              online_code = OnlineCode.find_or_initialize_by(code: row['Code'])
              online_code.used = row['Used']
              reward = Reward.find_by(id: row['Reward'])
     if reward
              online_code.reward = reward
     else
              puts "Warning: Reward with ID #{row['Reward']} not found in the database."
     end
              online_code.save!
      end
    end
  end
