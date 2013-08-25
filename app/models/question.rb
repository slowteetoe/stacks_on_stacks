class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  embeds_many :answers
  embeds_many :comments

  field :body, type: String
  field :title, type: String
  field :author, type: String

  # Make this model searchable via elasticsearch
  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name "stacks-on-stacks-#{Rails.env}"

  settings :analysis =>{
            :analyzer => {
              :default => {
                :type => 'snowball'
              }
            }
    } do
    mapping do
      indexes :body, analyzer: :snowball, boost: 10
      indexes :title, analyzer: :snowball, boost: 100
      indexes :answers
      indexes :comments
      indexes :author, index: :not_analyzed
      indexes :created_at, type: 'date', index: :not_analyzed

      indexes :answers do
        indexes :body, analyzer: :snowball
      end

      indexes :comments do
        indexes :body, analyzer: :snowball
      end
    end
  end

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
