class Answer
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :questions
  embeds_many :comments

  field :body, type: String
  field :author, type: String

  # This should all get extracted into a module
  field :upvotes, type: Array, default: []
  field :downvotes, type: Array, default: []

  def voted(username)
    upvotes.include?(username) || downvotes.include?(username)
  end

  def vote_count
    upvotes.size - downvotes.size
  end

  def voter_count
    upvotes.size + downvotes.size
  end

  def upvote(username)
    return if upvotes.include? username
    downvotes.delete username
    upvotes << username
  end

  def remove_vote(username)
    upvotes.delete username
    downvotes.delete username
  end

  def downvote(username)
    return if downvotes.include? username
    upvotes.delete username
    downvotes << username
  end

end
