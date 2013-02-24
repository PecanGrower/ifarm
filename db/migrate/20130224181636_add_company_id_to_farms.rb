class AddCompanyIdToFarms < ActiveRecord::Migration
  def change
    add_column :farms, :company_id, :integer
    add_index :farms, :company_id
  end
end
