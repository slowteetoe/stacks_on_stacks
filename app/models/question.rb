class Question
  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps
  include Tire::Model::Search
  include Tire::Model::Callbacks

  before_save :build_usernames_array
  before_update :update_vote_count, if: proc { upvotes_changed? || downvotes_changed? }

  belongs_to :user
  embeds_many :answers
  embeds_many :comments

  field :body, type: String
  field :title, type: String
  field :author, type: String
  field :usernames, type: Array, default: []
  field :votes_count, type: Integer, default: 0
  field :answers_count, type: Integer, default: 0

  validates_presence_of :body
  validates_presence_of :title
  validates_presence_of :tags

  # Make this model searchable via elasticsearch
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
      indexes :votes_count
      indexes :answers_count
      indexes :created_at, type: 'date', index: :not_analyzed

      indexes :answers do
        indexes :body, analyzer: :snowball
      end

      indexes :comments do
        indexes :body, analyzer: :snowball
      end
    end
  end

  def referenced_profiles
    users = User.in(username: self.usernames)
    Hash[users.map { |user| [user.username, user.profile] }]
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

  def update_vote_count
    self.votes_count = vote_count
  end

  private

  def build_usernames_array
    usernames = self.usernames
    usernames << self.author

    if self.comments.size > 0
      for comment in self.comments
        usernames << comment.author
      end
    end 

    if self.answers.size > 0
      for answer in self.answers
        usernames << answer.author

        if answer.comments.size > 0
          for comment in answer.comments
            usernames << comment.author
          end
        end
      end
    end

    self.usernames = usernames.uniq
  end

end
