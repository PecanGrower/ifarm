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
    it { should have_selector 'td', text: farm.name }
  end
end
