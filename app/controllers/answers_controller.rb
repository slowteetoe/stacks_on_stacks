class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [:create]
  before_action :set_question, only: [:create, :update]
  before_action :set_answer, except: [:create]

  def create
    @question.answers << Answer.new(body: params[:answer][:body], author: current_user.username)
    @question.save!
    redirect_to @question, notice: "Answer submitted!"
  end

  def update
    @answer.update_attributes(answer_params)
    redirect_to @question, notice: 'Answer updated!'
  end

  def upvote
    @answer.upvote current_user.username
    @answer.questions.save!
    redirect_to @answer.questions
  end

  def downvote
    @answer.downvote current_user.username
    @answer.questions.save!
    redirect_to @answer.questions
  end

  def remove_vote
    @answer.remove_vote current_user.username
    @answer.questions.save!
    redirect_to @answer.questions
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    id = params[:id]
    @answer = Question.where('answers._id' => Moped::BSON::ObjectId(id)).first.answers.detect { |c| c.id.to_s == id.to_s }
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
