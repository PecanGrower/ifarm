require 'spec_helper'

describe SoilClass do
  let(:soil_class) { SoilClass.new }

  subject { soil_class }

  describe "attribute" do
    it { should have_db_column :name }
    it { should have_db_column :aw }
  end

  describe "relationship" do
    it { should have_many :fields }
  end
end