require 'csv'

desc "Import ETo data from csv file"
task import_et: :environment do

  file = "db/fabian_garcia.csv"

  CSV.foreach(file, headers: true) do |row|
    Et.create! row.to_hash
  end
end