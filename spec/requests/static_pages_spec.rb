require 'spec_helper'

describe "User visiting the website" do

  subject { page }

  describe "The user visiting the home page" do
    before { visit root_path }

    it { should have_title ("Excitest") }
    it { should have_content ("Excitest") }
    it { should have_content ("A simple self learning tool that makes learning and tests exciting!") }

  end

  describe "The user visiting the about page" do
    before { visit about_path }

    it { should have_title ("About - Excitest") }
    it { should have_content ("About Excitest") }
    it { should have_content ("A simple self learning tool that makes learning and tests exciting!") }

  end

end
