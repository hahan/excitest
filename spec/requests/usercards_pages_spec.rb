require 'spec_helper'

describe "User visits the cards pages" do

  subject { page }

  describe "User visits the new cards pages" do

    before { visit new_cards_path }

    it { should have_title ("New cards - LearnBird") }
    it { should have_content ("Create your learn cards here by adding content you want to learn in left with their translation or desciption in right.") }
    it { should have_text ("Name") }
    it { should have_text ("Description") }
    it { should have_button ("create_cards") }

  end
end
