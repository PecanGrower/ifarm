require 'spec_helper'

describe "Farm" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in(user)
    Company.current_id = user.company.id
  end

  describe "index page" do

    let!(:farm) { FactoryGirl.create(:farm) }

    before { visit farms_path }

    it { should have_selector 'title', text: full_title('Farm') }
    it { should have_link farm.name, href: farm_path(farm) }
    it { should have_link('New Farm', href: new_farm_path) }
  end

  describe "show page" do
    let!(:farm) { FactoryGirl.create(:farm) }
    let!(:block) { FactoryGirl.create(:block, farm: farm) }
    let!(:field) { FactoryGirl.create(:field, block: block) }

    before { visit farm_path(farm) }

    it { should have_selector 'title', text: full_title(farm.name) }
    it { should have_selector 'h1', text: farm.name }
    it { should have_selector 'li', text: block.name }
    it { should have_selector 'li', text: field.name }
    it { should have_link 'Back to Farms', href: farms_path }
    it { should have_link 'Edit', href: edit_farm_path(farm) }
  end

  describe "new page" do
    before { visit new_farm_path }
    let(:submit) { "Save" }

    it { should have_selector 'title', text: full_title('Add Farm') }
    it { should have_selector 'h1', text: 'Add Farm' }

    it "should create a new farm" do
      fill_in "Farm Name", with: "Farm #1"
      expect do
        click_button submit
        Company.current_id = user.company.id
      end.to change(Farm, :count).by(1)
    end
  end

  describe "edit page" do
    let!(:farm) { FactoryGirl.create(:farm) }

    before { visit edit_farm_path(farm) }

    it { should have_selector 'title', text: "Edit #{farm.name}" }
    it { should have_selector 'h1', text: "Edit #{farm.name}" }
    it { should have_link "Cancel", href: farm_path(farm) }

    context "with invalid information" do
      let(:new_name) { "" }
      let(:submit) { "Save" }
      before do
        fill_in "Farm Name", with: new_name
        click_button submit
      end

      it { should have_selector 'title', text: "Edit #{new_name}" }
      it { should have_css '.alert-error' }
    end

    context "with valid information" do
      let(:new_name) { "New Name" }
      let(:submit) { "Save" }
      before do
        fill_in "Farm Name", with: new_name
        click_button submit
      end

      it { should have_selector 'title', text: full_title(new_name) }
      it { should have_css '.alert-success', text: "Updated" }
      specify { farm.reload.name.should == new_name }
      
    end
  end
end