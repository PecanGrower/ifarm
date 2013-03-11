# == Schema Information
#
# Table name: blocks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  farm_id    :integer
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Block do

  valid_attributes = { name: "1" }
  let(:company) { FactoryGirl.create(:company) }
  let(:farm) { FactoryGirl.create(:farm) }
  let(:block) { farm.blocks.build(valid_attributes) }

  before do
    Company.current_id = company.id
  end

  subject { block }

  it { should be_valid }

  it "should have a valid factory" do
    factory = FactoryGirl.build(:block)
    expect(factory).to be_valid
  end

  it { should accept_nested_attributes_for :fields }

  describe "tenant security" do
    
    it "should have on the current company's data" do
      wrong_company = FactoryGirl.create(:company)
      Company.current_id = wrong_company.id
      parent = FactoryGirl.create(:farm)
      expect(parent).to be_valid
      child = parent.blocks.create(valid_attributes)
      expect(child).to be_valid
      Company.current_id = company.id
      block.save
      expect(Block.all).not_to include(child)
      expect(Block.all).to include(block)
    end
  end

  describe "attributes" do
    it { should have_db_column :name }
    it { should have_db_column :farm_id }
    it { should have_db_column :company_id }

    context "protected from mass assignment" do
      it { should_not allow_mass_assignment_of :farm_id }
      it { should_not allow_mass_assignment_of :company_id }
      it { should allow_mass_assignment_of :fields_attributes }
    end
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).scoped_to :farm_id }
    it { should ensure_length_of(:name).is_at_most 10 }
    it { should_not validate_presence_of :farm_id }
    it { should validate_presence_of :company_id }
  end
end
