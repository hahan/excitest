require 'spec_helper'

describe "User visits the cards pages" do

  subject { page }

  describe "User visits the new cards pages" do

    before { visit newcard_path }

    it { should have_title ("New cards - LearnBird") }
    it { should have_content ("Create your learn cards here by adding content you want to learn in left with their translation or desciption in right.") }
    it { should have_text ("Name") }
    it { should have_text ("Description") }
    it { should have_button ("Create cards") }

  end

  describe "User creates a new card" do

    let (:submit) { "Create cards" }

    before do
      visit newcard_path

      fill_in "Name", with: "English to german translation"
      fill_in "Description", with: "Translation card"
      fill_in "Entry key", with: "word1"
      fill_in "Entry value", with: "word2"
    end

    it "should create a user card" do
      expect { click_button submit }.to change(UserCard, :count).by(1)
    end


  end

end
