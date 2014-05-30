require 'spec_helper'

describe UserCardEntry do
  let(:user_card) { FactoryGirl.create(:user_card) }

  before do
    @user_card_entry =  user_card.user_card_entries.build( entry_key:"word1", entry_value:"description1" )
  end

  subject { @user_card_entry }

  it { should respond_to(:entry_key) }
  it { should respond_to(:entry_value) }
  it { should respond_to(:user_card_id) }
  it { should respond_to(:user_card) }
  it { should be_valid}

  describe "when entry key is not present" do
    before { @user_card_entry.entry_key="" }

    it { should_not be_valid}
  end

  describe "when entry value is not present" do
    before { @user_card_entry.entry_value="" }

    it { should_not be_valid}
  end


end
