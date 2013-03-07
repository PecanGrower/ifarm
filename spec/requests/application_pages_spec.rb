require 'spec_helper'

describe "ApplicationPages" do
  let(:user) { FactoryGirl.create(:user) }
  subject { page }

  before do
    sign_in(user)
    visit root_path
  end

  describe "sidebar" do
    
    it { should have_css '.sidebar-nav' }

    context "when not signed in" do
      before do
        click_link 'Sign out'
        visit root_path
      end 

      it { should_not have_css '.sidebar-nav' }
    end
  end
end
