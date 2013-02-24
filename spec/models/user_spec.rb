# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  company_id      :integer
#

require 'spec_helper'

describe User do
 
  valid_attributes = { email: "user@example.com",
                       password: "foobar", 
                       password_confirmation: "foobar" }

  let(:company) { FactoryGirl.create(:company) }
  let(:user) { company.users.new(valid_attributes) }

  subject { user }

  it { should be_valid }
  it "should have a valid factory" do
    factory_user = FactoryGirl.build(:user)
    expect(factory_user).to be_valid
  end

  describe "attributes" do
    it { should have_db_column(:email) }
    it { should have_db_column(:password_digest) }
    it { should have_db_column(:remember_token) }
    it { should have_db_column(:company_id) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }

    context "protected from mass assignment" do
      it { should_not allow_mass_assignment_of :password_digest }
      it { should_not allow_mass_assignment_of :remember_token }
      it { should_not allow_mass_assignment_of :company_id }
    end
  end

  describe "associations" do
    it { should respond_to :company }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should ensure_length_of(:password).is_at_least(6) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:password_confirmation) }

    it "should validate format of e-mail" do
      valid = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      invalid = %w[user@foo,com user_at_foo.org example.user@foo.
                             foo@bar_baz.com foo@bar+baz.com]
      
      valid.each do |valid_address|
        expect(user).to validate_format_of(:email).with(valid_address)
      end      
      
      invalid.each do |invalid_address|
        expect(user).to validate_format_of(:email).not_with(invalid_address)
      end      
    end

    it "should be save email as all lower-case" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      user.email = mixed_case_email
      user.save
      user.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "methods" do
    describe "create_remember_token" do
      before { user.save }
      its(:remember_token) { should_not be_blank }
    end
  end
end
