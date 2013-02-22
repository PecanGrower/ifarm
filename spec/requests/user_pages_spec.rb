require 'spec_helper'

describe "User Pages" do
  subject { page }

  # User.create(name: "Sample User",
  #             email: "sample.user@example.net",
  #             password: "password",
  #             password_confirmation: "password")
  # let(:user) { User.last }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign up') }    
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
end
