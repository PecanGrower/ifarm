# == Schema Information
#
# Table name: fields
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  acreage    :decimal(, )
#  block_id   :integer
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Field do

  valid_attributes = { name: "1",
                       acreage: 10.5 }
  let(:company) { FactoryGirl.create(:company) }                       

  before do
    Company.current_id = company.id
    @block = FactoryGirl.create(:block)    
    @field = @block.fields.build(valid_attributes)
  end

  subject { @field }

  it { should be_valid }
  specify { @block.should be_valid }

  it "should have a valid factory" do
    field = FactoryGirl.build(:field)
    expect(field).to be_valid
  end

  describe "tenant security" do

    it "should have only the current company's data" do
      wrong_company = FactoryGirl.create(:company)
      Company.current_id = wrong_company.id
      parent = FactoryGirl.create(:block)
      expect(parent).to be_valid
      child = parent.fields.create(valid_attributes)
      expect(child).to be_valid
      Company.current_id = company.id
      @field.save
      expect(Field.all).not_to include(child)
      expect(Field.all).to include(@field)
    end
  end

  describe "attributes" do
    it { should have_db_column :name }
    it { should have_db_column :acreage }
    it { should have_db_column :block_id }
    it { should have_db_column :company_id }

    context "protected from mass assignment" do
      it { should_not allow_mass_assignment_of :block_id }
      it { should_not allow_mass_assignment_of :company_id }
    end
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).scoped_to :block_id }
    it { should ensure_length_of(:name).is_at_most 10 }
    it { should validate_numericality_of :acreage }
    it { should validate_presence_of :block_id }
    it { should validate_presence_of :company_id }
  end
end
