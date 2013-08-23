class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  # Make this model searchable
  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name "stacks-on-stacks-#{Rails.env}"

  mapping do
    indexes :_id, index: :not_analyzed
    indexes :username, index: :not_analyzed
    indexes :body, analyzer: 'snowball', boost: 100
    indexes :answers, analyzer: 'snowball'
    indexes :comments, analyzer: 'snowball'
    indexes :created_at, type: 'date', index: :not_analyzed
  end

  def to_indexed_json
    self.to_json
  end

  belongs_to :user
  embeds_many :answers
  embeds_many :comments

  field :body, type: String
  field :username, type: String

end
