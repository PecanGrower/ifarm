require 'spec_helper'

describe "Irrigation" do

  let(:user) { FactoryGirl.create(:user) }
  subject { page }

  before do
    sign_in(user)
    Company.current_id = user.company.id
  end
  
  describe "index page" do

    describe "previous irrigations list" do
      let!(:irrigation) { FactoryGirl.create(:irrigation) }
      let!(:new_irrigation) do
        FactoryGirl.create(:irrigation, time: irrigation.time + 1)
      end

      before { visit irrigations_path }
        
      it { should have_selector 'title', text: full_title('Irrigations') }
      it { should have_selector 'h1', text: 'Current Irrigations' }
      it { should have_selector 'td', text: irrigation.time.to_s }
      it "should have the correct sort order" do
        first_irrigation = page.body.index(irrigation.time.to_s)
        second_irrigation = page.body.index(new_irrigation.time.to_s)
        expect(second_irrigation).to be < first_irrigation
      end
    end

    describe "new irrigation form" do

      xit "should create a new irrigation with valid input" do
        visit irrigations_path
        Company.current_id = user.company.id
        block = FactoryGirl.create(:block, name: '1')
        FactoryGirl.create(:field, name: '1', block: block)
        select('1-1', from: 'Field')
        fill_in "Date and Time", with: "4/1/2013 14:50"
        click_button "Save"
        expect(page).to have_selector 'td', text: '1-1'
      end
    end


  end  
end