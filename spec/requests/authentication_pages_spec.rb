require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',    text:'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
    it { should have_link('Sign up now!', href: signup_path) }

    context "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_css('div.alert.alert-error', text: 'Invalid') }

      context "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_css('div.alert.alert-error') }
      end
    end

    context "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_selector('title', text: user.company.name) }

      context "followed by signout" do
        before { click_link "Sign out" }
        
        it { should have_link('Sign in') }
      end
    end
  end

  describe "authorization" do
    let(:user) { FactoryGirl.create(:user) }

    context "for non-signed-in users" do

      context "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          sign_in(user)
        end

        it "should render the desired protected page after signing in" do
          expect(page).to have_selector('title', text: 'Edit login')
        end

        it "should render the default(profile) page when signing in again" do
          delete signout_path
          sign_in(user)
          expect(page).to have_selector('title', text: user.company.name)
        end
      end

      context "in the Users controller" do
        
        context "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
          it { should have_css('div.alert.alert-notice') }
        end

        context "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end  
      end
    end

    context "for correct company" do
      
      it "should return the correct Company.current_id for the current user" do
        sign_in(user)
        expect(Company.current_id).to eq user.company.id
      end
    end

    
  end
end
