class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :question
  embedded_in :answer

  field :body, type: String
  field :author, type: String
  field :parent, type: String

end