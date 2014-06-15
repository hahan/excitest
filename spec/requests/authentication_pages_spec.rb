require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  before { visit signin_path }

  describe "User visits the signin page" do
    it { should have_title ("Sign in - Excitest") }

    it { should have_text ("Email") }
    it { should have_text ("Password") }
    it { should have_button ("Sign in") }
  end

  describe "with invalid information" do
    before { click_button "Sign in" }

    it { should have_title('Sign in') }
    it { should have_selector('div.alert.alert-error') }
  end

  describe "as non-admin user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:non_admin) { FactoryGirl.create(:user) }

    before { sign_in non_admin, no_capybara: true }

    describe "submitting a DELETE request to the Users#destroy action" do
      before { delete user_path(user) }
      specify { expect(response).to redirect_to(root_url) }
    end
  end

=begin
  describe "with valid information" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      fill_in "Email",    with: user.email.upcase
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    it { should have_title(user.name) }
    #it { should have_link('Profile',     href: user_path(user)) }
    it { should have_link('Sign out',    href: signout_path) }
    it { should_not have_link('Sign in', href: signin_path) }

    describe "followed by signout" do
      before { click_link "Sign out" }
      it { should have_link('Sign in') }
    end
  end
=end



end
