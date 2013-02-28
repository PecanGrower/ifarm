require 'spec_helper'

describe Block do

  valid_attributes = { name: "1" }
  let(:company) { FactoryGirl.create(:company) }

  before do
    Company.current_id = company.id
    @farm = Farm.create(FactoryGirl.attributes_for(:farm))
    @block = @farm.blocks.build(valid_attributes)
  end

  subject { @block }

  it { should be_valid }

  it "should have a valid factory" do
    block = FactoryGirl.build(:block)
    expect(block).to be_valid
  end

  describe "tenant security" do
    
    it "should have on the current company's data" do
      wrong_company = FactoryGirl.create(:company)
      Company.current_id = wrong_company.id
      wrong_data = @farm.blocks.create(name: "Wrong")
      Company.current_id = company.id
      @block.save
      expect(Block.all).not_to include(wrong_data)
      expect(Block.all).to include(@block)
    end
  end

  describe "attributes" do
    it { should have_db_column :name }
    it { should have_db_column :farm_id }
    it { should have_db_column :company_id }

    context "protected from mass assignment" do
      it { should_not allow_mass_assignment_of :farm_id }
      it { should_not allow_mass_assignment_of :company_id }
    end
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).scoped_to :farm_id }
    it { should ensure_length_of(:name).is_at_most 10 }
    it { should validate_presence_of :farm_id }
    it { should validate_presence_of :company_id }
  end
end
