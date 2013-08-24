class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.author = current_user.username
    @answer.save!
    redirect_to @question, :notice => "Answer submitted!"  
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
