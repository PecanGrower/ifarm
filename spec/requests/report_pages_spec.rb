require 'spec_helper'

describe "ReportPages" do
 
 subject { page }

 let(:user) { FactoryGirl.create(:user) }

 before do
   sign_in(user)
   Company.current_id = user.company.id
 end

 describe "show page" do
   
   context "for Next Irrigations" do
     
     before { visit report_path(:next_irrigation) }

     it { should have_selector 'title', text: full_title('Next Irrigations') }
   end
 end
end
