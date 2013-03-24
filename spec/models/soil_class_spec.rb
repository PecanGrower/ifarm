require 'spec_helper'

describe SoilClass do
  let(:soil_class) { SoilClass.new }

  subject { soil_class }

  describe "attributes" do
    it { should have_db_column :name }
    it { should have_db_column :aw }
  end
end