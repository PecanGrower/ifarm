require 'spec_helper'

describe "StaticPages" do

  let(:user) { FactoryGirl.create(:user) }

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end
  
  describe "Home page" do

    before { visit root_path }
    let(:heading) { 'iFarmPro' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector('title', text: '| Home') }
  end

  describe "Help page" do
    
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    
    before { visit about_path }
    let(:heading) { 'About iFarmPro' }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do

    before { visit contact_path }
    let(:heading) { 'Contact iFarmPro' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
  end

  describe "layout links" do
    
    context "when signed out" do

      it "should have the correct links" do
        visit root_path
        click_link "Help"
        should have_selector 'title', text: full_title('Help')
        click_link "Sign in"
        should have_selector 'title', text: full_title('Sign in')
        click_link "Home"
        should have_selector 'title', text: full_title('')
        click_link "About"
        should have_selector 'title', text: full_title('About')
        click_link "Contact"
        should have_selector 'title', text: full_title('Contact')
        click_link "iFarmPro"
        should have_selector 'title', text: full_title('')
        click_link "Sign up now!"
        should have_selector 'title', text: full_title('Sign up')
      end
    end

    context "when signed in" do

      it "should have the correct links" do
        sign_in(user)
        click_link "Help"
        should have_selector 'title', text: full_title('Help')
        # click_link "Farms"
        # should have_selector 'title', text: full_title('Edit farms')
        click_link "Company"
        should have_selector 'title', text: full_title(user.company.name)
        click_link "Settings"
        should have_selector 'title', text: full_title('Edit login')
        click_link "Home"
        should have_selector 'title', text: full_title('')
        click_link "About"
        should have_selector 'title', text: full_title('About')
        click_link "Contact"
        should have_selector 'title', text: full_title('Contact')
        click_link "iFarmPro"
        should have_selector 'title', text: full_title(user.company.name)
        click_link "Sign out"
        should have_selector 'title', text: full_title('')
      end
    end
  end
end