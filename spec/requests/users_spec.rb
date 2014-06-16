require 'spec_helper'

describe "User visits various profile pages" do

  subject { page }

  describe "User visits the signup page" do
    before { visit signup_path }

    it { should have_title ("Signup - Excitest") }

    it { should have_field ("Name") }
    it { should have_field ("Email") }
    it { should have_field ("Password") }
    it { should have_field ("Password confirmation") }
    it { should have_button ("Create account") }
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

  describe "User visits the profile page after creating cards" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:user_card) { FactoryGirl.create(:user_card, user:user) }

    before do
      sign_in user
      visit user_path(user)
    end

    it { should have_text (user.name) }
    it { should have_text (user_card.name) }

  end

=begin
  describe "forbidden attributes" do
    let(:user) { FactoryGirl.create(:user) }

    let(:params) do
      { user: { admin: true, password: user.password,
                password_confirmation: user.password } }
    end
    before do
      sign_in user, no_capybara: true
      patch user_path(user), params
    end
    specify { expect(user.reload).not_to be_admin }
  end
=end


  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }

        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end

  end


end
