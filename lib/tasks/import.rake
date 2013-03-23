require 'csv'

namespace :import do
  desc "Import ETo data from csv file"
  task et: :environment do

    file = "db/et0.csv"

    CSV.foreach(file, headers: true) do |row|
      et = Et.find_by_doy(row["doy"]) || Et.new
      et.attributes = row.to_hash
      et.save!
    end
  end  

  desc "Import KCref data from csv file"
  task kc: :environment do

    file = "db/kcref.csv"

    CSV.foreach(file, headers: true) do |row|
      kc = Kc.find_by_doy(row["doy"]) || Kc.new
      kc.attributes = row.to_hash
      kc.save!
    end
  end  
end