class SearchController < ApplicationController
  def index
    @questions = QuestionRepository.new(params).search
  end
end
