class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  embeds_many :answers
  embeds_many :comments

  field :body, type: String
  field :title, type: String
  field :username, type: String

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
      indexes :username, index: :not_analyzed
      indexes :created_at, type: 'date', index: :not_analyzed
    end
  end

end
