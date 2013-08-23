require 'spec_helper'

describe "profiles/edit" do
  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :display_name => "MyString",
      :gravatar_email => "MyString",
      :tagline => "MyString",
      :reputation => ""
    ))
  end

  it "renders the edit profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", profile_path(@profile), "post" do
      assert_select "input#profile_display_name[name=?]", "profile[display_name]"
      assert_select "input#profile_gravatar_email[name=?]", "profile[gravatar_email]"
      assert_select "input#profile_tagline[name=?]", "profile[tagline]"
      assert_select "input#profile_reputation[name=?]", "profile[reputation]"
    end
  end
end
