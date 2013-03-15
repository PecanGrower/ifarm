class AddCompanyIdToIrrigations < ActiveRecord::Migration
  def change
    add_column :irrigations, :company_id, :integer
    add_index :irrigations, :company_id
  end
end
