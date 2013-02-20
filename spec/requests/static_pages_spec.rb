require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "iFarmPro" }
  
  describe "Home page" do

    before do
      visit root_path
    end
    
    it "should have content iFarmPro" do
      expect(page).to have_selector('h1', :text => 'iFarmPro')
    end

    it "should have the correct title" do
      expect(page).to have_selector('title', :text => "#{base_title}")
    end  

    it "should not have a custom page title" do
      expect(page).not_to have_selector('title', :text => "| Home")
    end
  end

  describe "Help page" do
    
    before do
      visit help_path
    end

    it "should have the content 'Help'" do
      expect(page).to have_selector('h1', :text => 'Help')
    end

    it "should have the correct title" do
      expect(page).to have_selector('title', :text => "#{base_title} | Help")
    end  
  end

  describe "About page" do
    
    before do
      visit about_path
    end

    it "should have the content 'About'" do
      expect(page).to have_selector('h1', :text => 'About')
    end

    it "should have the correct title" do
      expect(page).to have_selector('title', :text => "#{base_title} | About")
    end  
  end

  describe "Contact page" do

    before do
      visit contact_path
    end

    it "should have the content 'Contact iFarm" do
      page.should have_selector("h1", :text => "Contact iFarm")
    end

    it "should have the correct title" do
      expect(page).to have_selector('title', :text => "#{base_title} | Contact")
    end  
  end
end
