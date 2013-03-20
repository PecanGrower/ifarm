require 'spec_helper'

describe SessionsController do

  describe "POST create" do
    
    context "with valid attributes" do

      before do
        @user = FactoryGirl.create(:user)
        Company.current_id = @user.company.id
        @farm = FactoryGirl.create(:farm)
        @attr = { email: @user.email, password: @user.password }
        post :create, session: @attr
        Company.current_id = @user.company.id
      end

      specify { session[:remember_token].should eq @user.remember_token }
      specify { session[:farm_id].should eq @farm.id }
      specify { subject.send(:current_user).should eq @user }
      specify { subject.send(:current_farm).should eq @farm }
      

    end
  end
end