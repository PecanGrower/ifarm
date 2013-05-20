require 'spec_helper'

describe Rain do

  valid_attributes = { date: "5/1/2013", amount: 0.35 }
  let(:company) { create(:company) }
  let(:farm) { create(:farm) }
  let(:rain) { farm.rains.build(valid_attributes) }

  before { Company.current_id = company.id }

  subject { rain }

  it { should be_valid }

  it "should have a valid factory" do
    factory = build(:rain)
    expect(factory).to be_valid
  end

  describe "tenant security" do
    it "should have only the current company's data" do
      rain.save
      wrong_company = create(:company)
      Company.current_id = wrong_company.id
      wrong_data = create(:rain)
      expect(wrong_data).to be_valid
      Company.current_id = company.id
      expect(Rain.all).not_to include(wrong_data)
      expect(Rain.all).to include(rain)
    end
  end

  describe "attribute" do
    it { should have_db_column :date }
    it { should have_db_column :amount }
    it { should have_db_column :farm_id }
    it { should have_db_column :company_id }

    context "with mass assignment protection" do
      it { should_not allow_mass_assignment_of :farm_id }
      it { should_not allow_mass_assignment_of :company_id }
    end
  end

  describe "validation" do
    it { should validate_presence_of :date }
    it { should validate_uniqueness_of(:date).scoped_to :farm_id }
    it { should validate_presence_of :amount }
    it { should validate_numericality_of :amount }
    it { should validate_presence_of :farm_id }
  end
end