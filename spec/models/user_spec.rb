require 'spec_helper'

describe "User" do

  before { @user = User.new(name: "testuser", email: "testuser@gmail.com", password: "test123", password_confirmation: "test123") }

  subject { @user }

  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:remember_token)}
  it { should respond_to(:authenticate)}
  it { should respond_to(:admin) }
  it { should_not be_admin }

  it { should be_valid }

  describe "User with blank name" do
    before { @user.name = "" }
    it { should_not be_valid }
  end

  describe "User with long name" do
    before { @user.name = "s" * 211 }
    it { should_not be_valid }
  end

  describe "User with blank email should be invalid" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "User with invalid email address" do
    it "should be invalid" do
      invalid_email_addresses = %w[dsasd@wwds dsasd@.com wwq.com !qQ11#@.com ~dds@email.com]

      invalid_email_addresses.each do |invalid_email|
        @user.email=invalid_email
        expect( @user ).not_to be_valid
      end
    end
  end

  describe "User with valid addresses" do
    it "should be valid" do
      valid_email_addresses = %w[h@h.com hhq1qqw@email.com HfH4r@E.COM ]

      valid_email_addresses.each {
          |valid_email|
        @user.email=valid_email
        expect(@user).to be_valid
      }
    end
  end

  describe "Multiple users with same email address not allowed" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "User with blank password should be invalid" do
    before { @user.password = " ", @user.password_confirmation=" " }

    it { should be_invalid }
  end

  describe "User with password confirmation mismatch should be invalid" do
    before { @user.password_confirmation="mismatch" }

    it { should be_invalid }
  end

  describe "User's remember token should not be empty" do
    before { @user.save }

    its (:remember_token) { should_not be_blank }

  end

  describe "User with admin role" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "return value of the authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by( email:@user.email )}

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end

  end

  describe "User cards association" do
    before { @user.save }

    let!(:cards_one) do
      FactoryGirl.create(:user_card, user: @user, created_at: 1.day.ago)
    end
    let!(:cards_two) do
      FactoryGirl.create(:user_card, user: @user, created_at: 1.hour.ago)
    end

    it "should destroy associated user cards" do
      usercards = @user.user_cards.to_a
      @user.destroy
      expect(usercards).not_to be_empty
      usercards.each do |usercard|
        expect(UserCard.where(id: usercard.id)).to be_empty
      end
    end

  end

end
