require 'spec_helper'

describe Irrigation do
  valid_attributes = { time: Time.now }
  let(:company) { FactoryGirl.create(Company) }
  let(:field) { FactoryGirl.create(:field) }
  let(:irrigation) { field.irrigations.build(valid_attributes) }

  before { Company.current_id = company.id }

  subject { irrigation }

  it { should be_valid }

  it "should have a valid factory" do
    factory = FactoryGirl.build(:irrigation)
    expect(factory).to be_valid
  end

  describe "security" do
    
    it "should have only the current company's data" do
      irrigation.save
      wrong_company = FactoryGirl.create(:company)
      Company.current_id = wrong_company.id
      wrong_data = FactoryGirl.create(:irrigation)
      expect(wrong_data).to be_valid
      Company.current_id = company.id
      expect(Irrigation.all).not_to include(wrong_data)
      expect(Irrigation.all).to include(irrigation)
    end

    context "has mass assignment protection" do
      it { should_not allow_mass_assignment_of :field_id }
      it { should_not allow_mass_assignment_of :company_id }
    end
  end

  describe "attribute" do
    it { should have_db_column :time }
    it { should have_db_column :field_id }
    it { should have_db_column :company_id }
  end

  describe "validation" do
    it { should validate_presence_of :time }
  end

  describe "method" do
    
    describe ".next_irrigation" do
      
      it "should return a time" do
        expect(irrigation.next_irrigation).to be_kind_of(Time)
      end
    end
  end
end