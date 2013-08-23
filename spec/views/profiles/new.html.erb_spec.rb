require 'spec_helper'

describe "profiles/new" do
  before(:each) do
    assign(:profile, stub_model(Profile,
      :display_name => "MyString",
      :gravatar_email => "MyString",
      :tagline => "MyString",
      :reputation => ""
    ).as_new_record)
  end

  it "renders new profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", profiles_path, "post" do
      assert_select "input#profile_display_name[name=?]", "profile[display_name]"
      assert_select "input#profile_gravatar_email[name=?]", "profile[gravatar_email]"
      assert_select "input#profile_tagline[name=?]", "profile[tagline]"
      assert_select "input#profile_reputation[name=?]", "profile[reputation]"
    end
  end
end
