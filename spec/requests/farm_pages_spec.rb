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
  end

  describe "new page" do
    before { visit new_farm_path }
    let(:submit) { "Create New Farm" }

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
end