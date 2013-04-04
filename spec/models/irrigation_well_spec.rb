require 'spec_helper'

describe IrrigationWell do

  valid_attributes = { name: 'Pump 1', pod_code: 'lrg-12345-pod1' }
  let(:company) { FactoryGirl.create(:company) }
  let(:farm) { FactoryGirl.create(:farm) }
  let(:well) { farm.irrigation_wells.build(valid_attributes) }

  before do
    Company.current_id = company.id
  end

  it { should be_valid }

  it "should have a valid factory" do
    factory = FactoryGirl.build(:irrigation_well)
    expect(factory).to be_valid
  end
end