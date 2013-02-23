require 'spec_helper'

describe "Authentication pages" do
  subject { page }

  describe "signin" do
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
      it { should have_link('Profile', href: company_path(user.company)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      context "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
end
