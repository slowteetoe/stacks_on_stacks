class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :body, type: String
  field :username, type: String

end
