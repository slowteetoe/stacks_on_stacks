require 'spec_helper'

describe "profiles/show" do
  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :display_name => "Display Name",
      :gravatar_email => "Gravatar Email",
      :tagline => "Tagline",
      :reputation => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Display Name/)
    rendered.should match(/Gravatar Email/)
    rendered.should match(/Tagline/)
    rendered.should match(//)
  end
end
