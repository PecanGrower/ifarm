require 'spec_helper'

describe "IrrigationPages" do

  let(:user) { FactoryGirl.create(:user) }
  subject { page }

  before do
    sign_in(user)
    Company.current_id = user.company.id
  end
  
  describe "index" do
    before do
      # 5.times FactoryGirl.create(:irrigation)
      visit irrigations_path
    end

    it { should have_selector 'title', text: full_title('Irrigations') }


  end  

end
