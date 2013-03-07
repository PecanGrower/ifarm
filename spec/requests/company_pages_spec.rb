require 'spec_helper'

describe "Company" do
  let(:user) { FactoryGirl.create(:user) }
  subject { page }

  describe "authorization" do
    
    context "when not signed-in" do
      
    end

    context "when wrong user" do
      
    end
  end

  describe "signup page" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    it { should have_selector('title', text: full_title('Sign up')) }
    it { should have_selector('h1', text: 'Sign up') }

    context "with invalid information" do
      it "should not create a company when user is invalid" do
        fill_in "Company Name", with: "Big Old Farm"
        expect { click_button submit }.not_to change(Company, :count)
      end

      it "should not create a user when company is invalid" do
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "password"
        fill_in "Confirmation", with: "password"
        expect { click_button submit }.not_to change(User, :count)
      end

      it "should show error messages" do
        click_button submit
        expect(page).to have_css('div#error_explanation')
      end
    end

    context "with valid information" do
      before do
        fill_in "Company Name", with: "Big Old Farm"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "password"
        fill_in "Confirmation", with: "password"
      end

      it "should create a company" do
        expect { click_button submit }.to change(Company, :count).by(1)
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      context "redirects to the Company page" do
        before { click_button submit }
        it { should have_selector('title', text: full_title('Big Old Farm')) }
        it { should have_css('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end

  describe "show page" do
    before { sign_in(user) }
    
    it { should have_selector('title', text: user.company.name) }
  end
  
end
