# == Schema Information
#
# Table name: farms
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#

require 'spec_helper'

describe Farm do
  
  valid_attributes = { name: "North Farm" }
  let(:company) { FactoryGirl.create(Company) }
  let(:farm) { Farm.new(valid_attributes) }

  subject { farm }

  before { Company.current_id = company.id }

  it { should be_valid }

  it "should have a valid factory" do
    farm = FactoryGirl.build(:farm)
    expect(farm).to be_valid
  end

  describe "tenant security" do

    it "should have only the current company's data" do
      wrong_company = FactoryGirl.create(Company)
      Company.current_id = wrong_company.id
      wrong_data = Farm.create(name: "Wrong Farm")
      Company.current_id = company.id
      farm.save
      expect(Farm.all).not_to include(wrong_data)
      expect(Farm.all).to include(farm)
    end
  end

  describe "attributes" do
    it { should have_db_column :name }
    it { should have_db_column :company_id }

    context "protected from mass assignment" do
      it { should_not allow_mass_assignment_of :company_id }
    end

    # context "from associations" do
    #   it { should belong_to :company }
    # end
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:company_id) }
    it { should ensure_length_of(:name).is_at_most(50) }
    it { should validate_presence_of(:company_id) }
  end
end
