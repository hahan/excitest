require 'spec_helper'

describe "User visiting the website" do

  subject { page }

  describe "The user visiting the home page" do
    before { visit root_path }

    let!(:home_page_user) { FactoryGirl.create(:home_page_user) }
    let!(:user_card) { FactoryGirl.create(:user_card, user:home_page_user) }

    it { should have_title ("Excitest") }
    it { should have_content ("Excitest") }
    it { should have_content ("A simple self learning tool that makes learning exciting!") }
    it { should have_content ("Try out some learning lists") }
  end

  describe "The user visiting the about page" do
    before { visit about_path }

    it { should have_title ("About - Excitest") }
    it { should have_content ("About Excitest") }
    it { should have_content ("A simple self learning tool that makes learning exciting!") }

  end

  describe "The user searching for cards" do
    let (:submit) { "Create cards" }
    let(:user) { FactoryGirl.create(:user) }
    let!(:user_card) { FactoryGirl.create(:user_card, user:user) }

    describe "The searched card is present" do
      before do
        visit root_path
        fill_in "search_search_term", with: "English"

        form = all("form").first
        class << form
          def submit!
            Capybara::RackTest::Form.new(driver, native).submit({})
          end
        end
        form.submit!
      end
      it { should have_content("English to german translation") }
      it { should have_field ("search_search_term") }
    end

    describe "The searched card is not present" do
      before do
        visit root_path
        fill_in "search_search_term", with: "No such cards"

        form = all("form").first
        class << form
          def submit!
            Capybara::RackTest::Form.new(driver, native).submit({})
          end
        end
        form.submit!
      end
      it { should have_content("No user cards found.") }

    end
  end





end
