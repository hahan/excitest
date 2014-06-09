require 'spec_helper'

describe "User visits various profile pages" do

  subject { page }

  describe "User visits the signup page" do
    before { visit signup_path }

    it { should have_title ("Signup - Excitest") }
    it { should have_content ("New profile") }

    it { should have_text ("Name") }
    it { should have_text ("Email") }
    it { should have_text ("Password") }
    it { should have_text ("Password confirmation") }
    it { should have_button ("Signup") }
  end

  describe "User with valid inputs should signup" do
    let (:submit) { "Signup" }

    before do
      visit signup_path

      fill_in "Name", with: "hakim"
      fill_in "Email", with: "haha@haha.com"
      fill_in "Password", with: "Password123"
      fill_in "Password confirmation" , with: "Password123"

      it "should create a user profile" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

    end

  end

end
