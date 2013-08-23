class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  embeds_many :answers
  embeds_many :comments

  field :body, type: String
  field :title, type: String
  field :username, type: String

end
