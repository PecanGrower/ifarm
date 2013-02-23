# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

require 'spec_helper'

describe User do
 
  valid_attributes = { name: "Example User", 
                       email: "user@example.com",
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
    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:company_id) }

    context "protected from mass assignment" do
      it { should_not allow_mass_assignment_of :password_digest }
      it { should_not allow_mass_assignment_of :remember_token }
      it { should_not allow_mass_assignment_of :company_id }
    end

    context "from associations" do
      it { should respond_to :company }
    end

    context "that validates" do
      context "name" do
        it { should validate_presence_of(:name) }
        it { should ensure_length_of(:name).is_at_most(50) }
      end

      context "email" do
        it { should validate_presence_of(:email) }
        context "when email format is invalid" do
          it "should be invalid" do
            addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                           foo@bar_baz.com foo@bar+baz.com]
            addresses.each do |invalid_address|
              user.email = invalid_address
              user.should_not be_valid
            end      
          end
        end
        context "when email format is valid" do
          it "should be valid" do
            addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
            addresses.each do |valid_address|
              user.email = valid_address
              user.should be_valid
            end      
          end
        end
        context "when email address is already taken" do
          before do
            user_with_same_email = user.dup
            user_with_same_email.email = user.email.upcase
            user_with_same_email.save
          end

          it { should_not be_valid }
        end
        context "email address with mixed case" do
          let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

          it "should be saved as all lower-case" do
            user.email = mixed_case_email
            user.save
            user.reload.email.should == mixed_case_email.downcase
          end
        end
      end

      context "password" do
        it { should ensure_length_of(:password).is_at_least(6) }
        context "when password is not present" do
          before { user.password = user.password_confirmation = " " }
          it { should_not be_valid }
        end
        context "when password doesn't match confirmation" do
          before { user.password_confirmation = "mismatch" }
          it { should_not be_valid }
        end
      end

      it { should validate_presence_of(:password_confirmation) }

      context "company_id" do
        it { should validate_presence_of :company_id }
        it { should validate_numericality_of(:company_id).only_integer }
      end
    end
  end

  describe "methods" do
      it { should respond_to(:authenticate) }

      describe "return value of authenticate method" do
        before { user.save }
        let(:found_user) { User.find_by_email(user.email) }

        context "with valid password" do
          it { should == found_user.authenticate(user.password) }
        end

        context "with invalid password" do
          let(:user_for_invalid_password) { found_user.authenticate("invalid") }

          it { should_not == user_for_invalid_password }
          specify { user_for_invalid_password.should be_false }
        end
      end
  
      describe "remember_token" do
        before { user.save }
        its(:remember_token) { should_not be_blank }
      end
  end
end
