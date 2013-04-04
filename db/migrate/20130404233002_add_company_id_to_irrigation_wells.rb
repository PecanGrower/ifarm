class AddCompanyIdToIrrigationWells < ActiveRecord::Migration
  def change
    add_column :irrigation_wells, :company_id, :integer
    add_index :irrigation_wells, :company_id
  end
end
