class CommentsController < ApplicationController

	before_action :authenticate_user!, only: [:create]

	def create
		question = Question.find(params[:q_id])

		if comment_on_question?
			question.comments << build_comment
			question.save!
		elsif comment_on_answer?
			answer = question.answers.where(id: params[:a_id]).first
			answer.comments << build_comment
			answer.save!
		end
		redirect_to question, notice: "Comment submitted!"
	end

	private

	def comment_params
		params.require(:comment).permit(:body, :q_id, :a_id)
	end

	def build_comment
		Comment.new(body: params[:body], author: current_user.username)
	end

	def comment_on_question?
		!params[:a_id]
	end

	def comment_on_answer?
		!!params[:a_id]
	end

end
