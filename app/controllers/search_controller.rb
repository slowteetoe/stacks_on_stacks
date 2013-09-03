class SearchController < ApplicationController

	before_action :authenticate_user!

  def index
    @questions = QuestionRepository.new(params).search
  end

end
