class QuestionRepository
  POSTS_PER_PAGE = 20

  attr_accessor :params, :posts_per_page

  def initialize(params, posts_per_page = POSTS_PER_PAGE)
    self.params = params
    self.posts_per_page = posts_per_page
  end

  def search
    q = params[:query]
    d = params[:dir] || 'desc'
    c = params[:col] || 'created_at'

    Question.tire.search(load: true, page: params[:page], per_page: posts_per_page) do
      query { string q, default_operator: "OR" } if q.present?
      sort { by "#{c}", "#{d}" }
    end
  end

end