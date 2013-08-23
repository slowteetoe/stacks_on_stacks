class Answer
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :questions
  embeds_many :comments

  field :body, type: String
  field :author, type: String

end
