require 'csv'
  class ImportCsvService

    def call(file)

      opened_file = File.open(file)
      options = { headers: true, col_sep: ';' }
      data = CSV.foreach(opened_file, **options).map{ |row| row.to_h }
        Reward.upsert_all(data, unique_by: :title)
    end
  end


  

