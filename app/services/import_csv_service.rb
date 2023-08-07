require 'csv'
class ImportCsvService
  def call(file)
    opened_file = File.open(file)
    options = { headers: true, col_sep: ';' }
    CSV.foreach(opened_file, **options) do |row|
    current_row = row
            reward = Reward.find_or_initialize_by(title: row['Title'])
            reward.description = row['Description']
            reward.price = row['Price']
            reward.category = Category.find_or_create_by!(title: row['Category'])
            reward.delivery_method = row['Delivery method']
            reward.save!
    end
  end
end
