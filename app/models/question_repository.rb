class QuestionRepository
  POSTS_PER_PAGE = 5

  attr_accessor :params, :posts_per_page

  def initialize(params, posts_per_page = POSTS_PER_PAGE)
    self.params = params
    self.posts_per_page = posts_per_page
  end

  def search
    query = params[:query]
    # fake it until we have a questions model
    return { :title => "Why does this not appear?", :accepted_answer => "It should.", :original_query => query }
    model.tire.search(load: true, page: params[:page], per_page: posts_per_page) do
      query { string query, default_operator: "AND" } if query.present?
      filter :range, published_at: { lte: Time.zone.now }
      sort { by :published_at, "desc" } if query.blank?
    end
  end

  protected

  def model
    Question
  end
end