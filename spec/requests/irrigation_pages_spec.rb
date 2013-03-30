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
        FactoryGirl.create(:irrigation, time: irrigation.time + 1.day)
      end
      let(:field_name) { irrigation.field.name_with_block }

      before { visit irrigations_path }
        
      it { should have_selector 'title', text: full_title('Irrigations') }
      it { should have_selector 'h1', text: 'Current Irrigations' }
      it { should have_selector 'td', text: field_name }
      it { should have_selector 'td', text: irrigation.time.to_s(:long) }
      it "should have the correct sort order" do
        first = page.body.index(irrigation.time.to_s(:long))
        second = page.body.index(new_irrigation.time.to_s(:long))
        expect(second).to be < first
      end
    end

    describe "new irrigation form" do
      let!(:block) { FactoryGirl.create(:block) }
      let!(:field) { FactoryGirl.create(:field, block: block) }

      before do
        
      end

      context "with invalid data" do
        before do
          visit irrigations_path
          Company.current_id = user.company.id
          click_button 'Save'
        end

        it { should have_selector 'title', text: full_title('Irrigations') }
        it { should have_css '.alert-error' }
      end

      context "with valid data" do

        before do
          Company.current_id = user.company.id
          block = FactoryGirl.create(:block, name: '1')
          FactoryGirl.create(:field, name: '1', block: block)
          visit irrigations_path
          select('1-1', from: 'Field')
          fill_in "Time", with: "4/1/2013 14:50"
          click_button "Save"
        end

        it { should have_selector 'td', text: '1-1' }
        it "should parse using american_date" do
          expect(page).to have_selector 'td', text: 'April 01, 2013 14:50'
        end

      end

    end
  end  
end