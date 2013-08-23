# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    display_name "MyString"
    gravatar_email "MyString"
    tagline "MyString"
    reputation ""
  end
end
