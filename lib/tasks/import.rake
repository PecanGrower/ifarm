require 'csv'

namespace :import do
  desc "Import ETo data from csv file"
  task et: :environment do

    file = "db/et0.csv"

    CSV.foreach(file, headers: true) do |row|
      et = Et.find_by_doy(row["doy"]) || new
      et.attributes = row.to_hash
      et.save!
    end
  end  
end

