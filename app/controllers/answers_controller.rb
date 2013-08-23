class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit]

  def create
    @answer = Answer.new(answer_params)
    @answer.author = current_user.username

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @answer }
      else
        format.html { render action: 'new' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
