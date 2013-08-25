class AnswersController < ApplicationController

  def create
    if user_signed_in?
      question = Question.find(params[:question_id])
      question.answers << Answer.new(body: params[:answer][:body], author: current_user.username)
      question.save!
      redirect_to question, notice: "Answer submitted!"
    else
      redirect_to '/users/sign_in', alert: "You need to sign in or sign up before continuing."
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
