class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user, foreign_key: 'username'
  embeds_many :answers
  embeds_many :comments

  field :body, type: String
  field :username, type: String

end
