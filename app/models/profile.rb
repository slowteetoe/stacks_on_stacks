class Profile
  include Mongoid::Document
  include Gravtastic

  is_gravtastic!

  gravtastic :gravatar_email

  belongs_to :user
  field :display_name, type: String
  field :gravatar_email, type: String
  field :tagline, type: String
  field :reputation, type: Integer, :default => 0
end
