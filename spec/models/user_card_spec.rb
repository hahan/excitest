require 'spec_helper'

describe UserCard do

  before { @user_card = UserCard.new(name:"english to german translations", description: "english to german translations for my exam") }

  subject { @user_card }

  it { should respond_to (:name) }
  it { should respond_to (:description) }
  it { should respond_to(:user_card_entries) }
  it { should be_valid}

  describe "User card with empty name" do
    before { @user_card.name="" }
    it { should_not be_valid }
  end

  describe "User card with empty description" do
    before { @user_card.description="" }
    it { should_not be_valid }
  end

end
