# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Company do

  valid_attributes = { name: "Big Old Farm" }
  let(:company) { Company.new(valid_attributes) }

  subject { company }

  it { should be_valid }

  describe "attributes" do
    it { should respond_to :name }

    context "protected from mass assignment" do
      
    end

    context "from associations" do
      it { should respond_to :users }
      it { should accept_nested_attributes_for :users }
    end
  end

  describe "validations" do
    
    context "for name" do

      context "when blank" do
        before { company.name = " " }
        it { should be_invalid }
      end

      context "when too long" do
        before { company.name = "a" * 51 }
        it { should be_invalid }
      end
    end
  end

  describe "methods" do
    
  end
end
