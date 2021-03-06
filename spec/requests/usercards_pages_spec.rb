require 'spec_helper'

#TODO Add tests for edit and delete cards

describe "User visits the cards pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  before { sign_in user }

  describe "User visits the new cards pages" do

    before { visit newcard_path }

    it { should have_title ("New list - Excitest") }
    it { should have_content ("About your learning list") }
    it { should have_field ("Name") }
    it { should have_field ("Description") }

    it { should have_content ("Your learning list terms") }
    it { should have_button ("Create") }

  end

  describe "User creates a new card" do

    let (:submit) { "Create" }

    before do
      visit newcard_path

      fill_in "Name", with: "English to german translation"
      fill_in "Description", with: "Translation card"

      fill_in "user_card[user_card_entries_attributes][0][entry_key]", with: "word1"
      fill_in "user_card[user_card_entries_attributes][0][entry_value]", with: "word2"

      fill_in "user_card[user_card_entries_attributes][1][entry_key]", with: "word1"
      fill_in "user_card[user_card_entries_attributes][1][entry_value]", with: "word2"

    end

    it "should create a user card" do
      expect { click_button submit }.to change(UserCard, :count).by(1)
    end


  end

end
