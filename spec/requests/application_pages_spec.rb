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
      end 

      it { should_not have_css '.sidebar-nav' }
    end

    it "should display the company name" do
      expect(page).to have_css('.sidebar-nav', text: user.company.name)
    end

    it "should have the correct links" do
      click_link "Farms"
      expect(page).to have_selector 'title', text: full_title('Farms')
      click_link "Irrigations"
      expect(page).to have_selector 'title', text: full_title('Irrigations')
    end
  end
end