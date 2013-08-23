require 'spec_helper'

describe "profiles/index" do
  before(:each) do
    assign(:profiles, [
      stub_model(Profile,
        :display_name => "Display Name",
        :gravatar_email => "Gravatar Email",
        :tagline => "Tagline",
        :reputation => ""
      ),
      stub_model(Profile,
        :display_name => "Display Name",
        :gravatar_email => "Gravatar Email",
        :tagline => "Tagline",
        :reputation => ""
      )
    ])
  end

  it "renders a list of profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Display Name".to_s, :count => 2
    assert_select "tr>td", :text => "Gravatar Email".to_s, :count => 2
    assert_select "tr>td", :text => "Tagline".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
