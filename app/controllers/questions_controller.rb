class QuestionsController < ApplicationController

  before_action :set_question, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :remove_vote]
  before_action :authenticate_user!, only: [:new, :show, :edit, :update, :index]

  def index
    if params[:srt]
      @questions = Question.order(params[:srt].to_sym, params[:dir].to_sym).page(params[:page]).per(20)
    else
      @questions = Question.order(:asked, :desc).page(params[:page]).per(20)
    end
  end

  def show
    @profiles = @question.referenced_profiles
  end

  def tags
    @tags = Question.tags_with_weight.sort {|a,b| b[1] <=> a[1]}
  end

  def tagged
    @questions = Question.tagged_with(params[:tag]).order_by(:created_at.desc).page(params[:page]).per(20)
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
    params.require(:question).permit(:title, :body, :tags)
  end
end
