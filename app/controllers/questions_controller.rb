class QuestionsController < ApplicationController

  before_action :set_question, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :remove_vote]
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.author = current_user.username
    @question.user = current_user

    if @question.save
      redirect_to @question, notice: 'Question asked!'
    else
      render action: 'new'
    end
  end

  def update
    if @question.update_attributes(question_params)
      redirect_to @question, notice: 'Question updated!'
    else
      render action: 'edit'
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_url
  end

  def upvote
    @question.upvote current_user.username
    @question.save!
    redirect_to @question
  end

  def downvote
    @question.downvote current_user.username
    @question.save!
    redirect_to @question
  end

  def remove_vote
    @question.remove_vote current_user.username
    @question.save!
    redirect_to @question
  end

private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
