require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "authorization" do
    context "for wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      context "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edit login')) }
      end

      context "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end
    
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end 

    describe "page" do
      it { should have_selector('title', text: "Edit login") }
      it { should have_selector('h1', text: "Update your login") }

      context "with invalid information" do
        before { click_button "Save changes" }

        it { should have_css('div.alert.alert-error') }
      end

      context "with valid information" do
        let(:new_email) { "new@example.com" }
        before do
          fill_in "Email",        with: new_email
          fill_in "Password",     with: user.password
          fill_in "Confirmation", with: user.password
          click_button "Save changes"
        end

        it { should have_selector('title', text: user.company.name) }
        it { should have_css('div.alert.alert-success') }
        it { should have_link('Sign out', href: signout_path) }
        specify { user.reload.email.should eq new_email }
      end
    end
  end
end
