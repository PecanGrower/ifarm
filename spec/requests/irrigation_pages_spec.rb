require 'spec_helper'

describe "IrrigationPages" do

  let(:user) { FactoryGirl.create(:user) }
  subject { page }

  before do
    sign_in(user)
    Company.current_id = user.company.id
  end
  
  describe "index" do
    let(:irrigation) { FactoryGirl.create(:irrigation) }
    before do
      visit irrigations_path
      Company.current_id = user.company.id
    end

    it { should have_selector 'title', text: full_title('Irrigations') }
    xit { should have_selector 'td', text: irrigation.time.to_s }


  end  
end