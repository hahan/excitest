require 'spec_helper'

describe "User visiting the website" do

  subject { page }

  describe "The user visiting the home page" do
    before { visit root_path }

    it { should have_title ("LearnBird") }
    it { should have_content ("LearnBird") }
    it { should have_content ("A simple self learning tool that makes it a lot of fun to learn new things") }

  end

  describe "The user visiting the about page" do
    before { visit about_path }

    it { should have_title ("About - LearnBird") }
    it { should have_content ("About LearnBird") }
    it { should have_content ("A simple self learning tool that makes it a lot of fun to learn new things") }

  end

end
