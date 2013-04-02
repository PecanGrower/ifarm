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

  describe "new" do
    let(:user) { FactoryGirl.create(:user) }
    let(:attr) { FactoryGirl.attributes_for(:user) }
    before do
      sign_in user
      visit new_user_path
      Company.current_id = user.company.id
    end

    context "with invalid information" do
      before do
        fill_in "Email", with: ""
        fill_in "Password", with: ""
        fill_in "Confirmation", with: ""        
      end

      it "should not create a user" do
        expect  do
          click_button "Add User"
        end.not_to change(User, :count)
      end

      it "should display error messages" do
        click_button "Add User"
        expect(page).to have_css '.alert-error'
      end
    end

    context "with valid information" do
      before do
        fill_in "Email", with: attr[:email]
        fill_in "Password", with: attr[:password]
        fill_in "Confirmation", with: attr[:password]
      end

      it "should create a new user" do
        expect do
          click_button "Add User"
        end.to change(User, :count).by(1)
      end

      it "should create a user for the correct company" do
        click_button "Add User"
        new_user = User.find_by_email(attr[:email])
        expect(new_user.company_id).to eq user.company_id
      end

      it "should have a success message" do
        click_button "Add User"
        expect(page).to have_css '.alert-success'
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
