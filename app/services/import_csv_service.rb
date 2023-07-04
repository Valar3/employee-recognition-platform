require 'csv'
  class ImportCsvService
    def call(file)
      opened_file = File.open(file)
      options = { headers: true, col_sep: ';' }
      CSV.foreach(opened_file, **options) do |row|
        Reward.create! row.to_hash.merge(category_id: category.id)
        #row_hash = row.to_hash.merge(category_id: category_id)
        #Reward.find_or_create_by!(row_hash)
        #Reward.create!(row.to_hash)
        #reward_hash = []
        #reward_hash[:title]= row['title']
        #reward_hash[:description] = row['description']
        #reward_hash[:price]= row['price']
        #reward_hash[:category_id] = row['category']
        #Reward.find_or_create_by(reward_hash, unique_by: :title)
      end
    end
  end

