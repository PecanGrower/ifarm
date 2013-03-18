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
     
     before do
       visit report_path(:next_irrigations)
       Company.current_id = user.company.id
     end

     it { should have_selector 'title', text: full_title('Next Irrigations') }

     context "with data" do
       
       let!(:irrigation) { FactoryGirl.create(:irrigation) }

       before { visit report_path(:next_irrigations) }

       it { should have_selector 'td', text: irrigation.time.to_s(:long) }
     end
   end
 end
end
