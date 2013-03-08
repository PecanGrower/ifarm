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
    let!(:block) { FactoryGirl.create(:block) }
    let!(:field) { FactoryGirl.create(:field) }

    before { visit farms_path }

    it { should have_selector 'title', text: full_title('Farm') }
    it { should have_selector 'td', text: farm.name }
    it { should have_selector 'td', text: block.name }
    it { should have_selector 'td', text: field.name}
    it { should have_link('New Farm', href: new_farm_path) }
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